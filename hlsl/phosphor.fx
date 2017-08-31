// license:BSD-3-Clause
// copyright-holders:Ryan Holtz
//-----------------------------------------------------------------------------
// PhosphorRGB Effect
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Sampler Definitions
//-----------------------------------------------------------------------------

texture Diffuse;

sampler DiffuseSampler = sampler_state
{
	Texture   = <Diffuse>;
	SRGBTexture = TRUE;
	MipFilter = LINEAR;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	AddressU = CLAMP;
	AddressV = CLAMP;
	AddressW = CLAMP;
};

texture LastPass;

sampler PreviousSampler = sampler_state
{
	Texture   = <LastPass>;
	SRGBTexture = TRUE;
	MipFilter = LINEAR;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	AddressU = CLAMP;
	AddressV = CLAMP;
	AddressW = CLAMP;
};

//-----------------------------------------------------------------------------
// Vertex Definitions
//-----------------------------------------------------------------------------

struct VS_OUTPUT
{
	float4 Position : POSITION;
	float4 Color : COLOR0;
	float2 TexCoord : TEXCOORD0;
	float2 PrevCoord : TEXCOORD1;
};

struct VS_INPUT
{
	float3 Position : POSITION;
	float4 Color : COLOR0;
	float2 TexCoord : TEXCOORD0;
};

struct PS_INPUT
{
	float4 Color : COLOR0;
	float2 TexCoord : TEXCOORD0;
	float2 PrevCoord : TEXCOORD1;
};

//-----------------------------------------------------------------------------
// PhosphorRGB Vertex Shader
//-----------------------------------------------------------------------------

uniform float2 ScreenDims;
uniform float2 TargetDims;

uniform bool Passthrough;

VS_OUTPUT vs_main(VS_INPUT Input)
{
	VS_OUTPUT Output = (VS_OUTPUT)0;

	Output.Position = float4(Input.Position.xyz, 1.0f);
	Output.Position.xy /= ScreenDims;
	Output.Position.y = 1.0f - Output.Position.y; // flip y
	Output.Position.xy -= 0.5f; // center
	Output.Position.xy *= 2.0f; // zoom

	Output.TexCoord = Input.TexCoord;
	Output.TexCoord += 0.5f / TargetDims; // half texel offset correction (DX9)

	Output.PrevCoord = Output.TexCoord;

	Output.Color = Input.Color;

	return Output;
}

//-----------------------------------------------------------------------------
// PhosphorRGB Pixel Shader
//-----------------------------------------------------------------------------

// Color Correction Matrices
//
// sRGB uses a white point D65.  It is identical to Rec. 709 used for HD
// video.  Note that UHD and digital cinema formats use a different gamut.
//
// NTSC 1953 uses a wide gamut with white point C.
//
// NTSC 1987 uses a distinct gamut with white point D65.
//
// NTSC-J uses the same gamut as NTSC 1987, but uses a white point around
// 9300 K.
//
// PAL 525 was used for all analog 525-line systems.  It uses the same gamut
// as NTSC 1987, but with white point C.
//
// SECAM/PAL 625 was used for all analog 625-line systems.  It uses a gamut
// nearly identical to sRGB with white point D65.
//
// Apple RGB has a unique gamut that mimics the 13" Apple RGB monitor. It uses
// white point D65.

static const float3x3 SRGB_TO_SRGB = {
	1.0f, 0.0f, 0.0f,
        0.0f, 1.0f, 0.0f,
	0.0f, 0.0f, 1.0f
};
static const float3x3 NTSC_1953_TO_SRGB = {
	 1.5073f, -0.3724f, -0.0833f,
        -0.0273f,  0.9350f,  0.0669f,
        -0.0271f,  0.0401f,  1.1672f
};
static const float3x3 NTSC_1987_TO_SRGB = {
	 0.9394f,  0.0502f, 0.0102f,
         0.0179f,  0.9658f, 0.0164f,
	-0.0016f, -0.0044f, 1.0060f
};
static const float3x3 NTSC_J_TO_SRGB = {
	 0.8292f,  0.0497f, 0.0140f,
         0.0158f,  0.9561f, 0.0225f,
	-0.0014f, -0.0043f, 1.3772f
};
static const float3x3 PAL_525_TO_SRGB = {
	 0.9917f,  0.0487f, 0.0112f,
         0.0189f,  0.9377f, 0.0181f,
	-0.0017f, -0.0042f, 1.1058f
};
static const float3x3 SECAM_TO_SRGB = {
	1.0439f, -0.0440f, -0.0000f,
        0.0001f,  1.0000f, -0.0000f,
	0.0000f,  0.0118f,  0.9882f
};
static const float3x3 APPLE_RGB_TO_SRGB = {
	1.0686f, -0.0786f, 0.0099f,
        0.0242f,  0.9601f, 0.0158f,
	0.0252f,  0.0298f, 0.9686f
};
static const float3x3 CORRECTION_MATRIX[] = {
	SRGB_TO_SRGB,
	NTSC_1953_TO_SRGB,
	NTSC_1987_TO_SRGB,
	NTSC_J_TO_SRGB,
	PAL_525_TO_SRGB,
	SECAM_TO_SRGB,
	APPLE_RGB_TO_SRGB
};
static const float3 LUMA_NTSC_1953 = { 0.30f, 0.59f, 0.11f };
static const float3 LUMA_REC_601 = { 0.299f, 0.587f, 0.114f };
static const float3 LUMA_REC_709 = { 0.2126f, 0.7152f, 0.0722f };
static const float3 LUMA[] = {
	LUMA_REC_709,
	LUMA_NTSC_1953,
	LUMA_REC_601,
	LUMA_REC_601,
	LUMA_REC_601,
	LUMA_REC_601,
	LUMA_REC_601
};
static const float3x3 XYZ_TO_SRGB = {  3.2406f, -1.5372f, -0.4986f,
                                      -0.9689f,  1.8758f,  0.0415f,
				       0.0557f, -0.2040f,  1.0570f
                                    };

static const float TAU_FACTOR[] = {
	434.29e-9f,
	4.3429e-6f,
	434.29e-6f,
	43.429e-3f,
	434.29e-3f,
	4.3429
};

static const float GAMMA_FACTOR[] = {
	2.1623e6f,
	216.23e3f,
	2.1623e3f,
	21.623f,
	2.1623f,
	216.23e-3f
};

uniform float3 Beta = { 0.0f, 0.0f, 0.0f };
uniform int ColorSpace = 0;
uniform int DecayModel = 0;
uniform float DeltaTime = 0.0f;
uniform float PhosphorChromaX = 0.0f;
uniform float PhosphorChromaY = 0.0f;
uniform float3 PhosphorRGB = { 0.0f, 0.0f, 0.0f };
uniform int PhosphorType = 0;
uniform int RateMode = 0;

float4 ps_main(PS_INPUT Input) : COLOR
{
	// Phosphor decay rates (time to 10% intensity)
	//
	// VL - 1s or more
	// L  - 100 ms to 1 s
	// M  - 1 to 100 ms
	// MS - 10 us to 1 ms
	// S  - 1 to 10 us
	// VS - 1 us or less

	const float4 CurrPix = tex2D(DiffuseSampler, Input.TexCoord);
	float3 PrevPix = tex2D(PreviousSampler, Input.PrevCoord).rgb;

	if (DecayModel == 0)
	{
		float3 tau = TAU_FACTOR[RateMode] * PhosphorRGB;
		PrevPix *= exp(-DeltaTime / tau);
	}
	else
	{
		float3 gamma = GAMMA_FACTOR[RateMode] / PhosphorRGB;
		float r = PrevPix.r;
		float g = PrevPix.g;
		float b = PrevPix.b;
		if (r != 0.0f)
			r = pow(gamma.r * DeltaTime + pow(1.0f / r, 1.0f / Beta.r),
			        -Beta.r);
		if (g != 0.0f)
			g = pow(gamma.g * DeltaTime + pow(1.0f / g, 1.0f / Beta.g),
			        -Beta.g);
		if (b != 0.0f)
			b = pow(gamma.b * DeltaTime + pow(1.0f / b, 1.0f / Beta.b),
			        -Beta.b);
		PrevPix = float3(r, g, b);
	}

	//const float3 one3 = { 1.0f, 1.0f, 1.0f };
	//float3 OutRGB = one3 - (one3 - PrevPix) * (one3 - CurrPix.rgb);
	float3 OutRGB = max(CurrPix.rgb, PrevPix);

	OutRGB = ColorSpace <= 6 ?
		 mul(CORRECTION_MATRIX[ColorSpace], OutRGB) :
		 OutRGB;
	if (PhosphorType != 0)
	{
		const float x = PhosphorChromaX;
		const float y = PhosphorChromaY;
		const float Y = dot(LUMA[ColorSpace], OutRGB);
		const float X = x * (Y / y);
		const float Z = (1.0f - x - y) * (Y / y);
		OutRGB = mul(XYZ_TO_SRGB, float3(X, Y, Z));
	}

	return Passthrough ?
	       CurrPix : float4(OutRGB, CurrPix.a);
}

//-----------------------------------------------------------------------------
// PhosphorRGB Technique
//-----------------------------------------------------------------------------

technique DefaultTechnique
{
	pass Pass0
	{
		Lighting = FALSE;

		VertexShader = compile vs_2_0 vs_main();
		PixelShader  = compile ps_2_0 ps_main();
	}
}
