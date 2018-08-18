// license:BSD-3-Clause
// copyright-holders:Ryan Holtz, Westley M. Martinez
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
static const float3x3 XYZ_TO_SRGB = {
	 3.2406f, -1.5372f, -0.4986f,
        -0.9689f,  1.8758f,  0.0415f,
	 0.0557f, -0.2040f,  1.0570f
};
static const float3x3 XYZ_TO_NTSC_1953 = {
	 1.9100f, -0.5325f, -0.2883f,
	-0.9846f,  1.9991f, -0.0282f,
	 0.0582f, -0.1183f,  0.8980f
};
static const float3x3 XYZ_TO_NTSC_1987 = {
	 3.5062f, -1.7398f, -0.5441f,
	-1.0694f,  1.9780f,  0.0352f,
	 0.0564f, -0.1970f,  1.0499f
};
static const float3x3 XYZ_TO_NTSC_J = {
	 3.9716f, -1.9709f, -0.6163f,
	-1.0800f,  1.9980f,  0.0356f,
	 0.0413f, -0.1440f,  0.7670f
};
static const float3x3 XYZ_TO_PAL_525 = {
	 3.3213f, -1.6478f, -0.5156f,
	-1.1011f,  2.0368f,  0.0363f,
	 0.0512f, -0.1792f,  0.9552f
};
static const float3x3 XYZ_TO_SECAM = {
	 3.0543f, -1.3892f, -0.4743f,
	-0.9577f,  1.8708f,  0.0398f,
	 0.0664f, -0.2282f,  1.0693f
};
static const float3x3 XYZ_TO_APPLE_RGB = {
	 2.9515f, -1.2892f, -0.4738f,
	-1.0849f,  1.9908f,  0.0372f,
	 0.0854f, -0.2694f,  1.0910f
};
static const float3x3 XYZ_TO_RGB[] = {
	XYZ_TO_SRGB,
	XYZ_TO_NTSC_1953,
	XYZ_TO_NTSC_1987,
	XYZ_TO_NTSC_J,
	XYZ_TO_PAL_525,
	XYZ_TO_SECAM,
	XYZ_TO_APPLE_RGB
};

uniform float3 Beta = { 0.0f, 0.0f, 0.0f };
uniform int DecayModel = 0;
uniform float DeltaTime = 0.0f;
uniform float3 PhosphorRGB = { 0.0f, 0.0f, 0.0f };
uniform int RateMode = 0;

uniform int ColorSpace = 0;
uniform float2 PhosphorChroma = { 0.0f, 0.0f };
uniform int PhosphorType = 0;

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

	float4 CurrPix = tex2D(DiffuseSampler, Input.TexCoord);
	float3 PrevPix = tex2D(PreviousSampler, Input.PrevCoord).rgb;

	if (PhosphorType != 0)
	{
		const float x = PhosphorChroma[0];
		const float y = PhosphorChroma[1];
		const float Y = dot(LUMA[ColorSpace], CurrPix.rgb);
		const float X = x * (Y / y);
		const float Z = (1.0f - x - y) * (Y / y);
		CurrPix.rgb = mul(XYZ_TO_RGB[ColorSpace], float3(X, Y, Z));
	}

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

	float3 OutRGB = CurrPix.rgb + PrevPix;

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
