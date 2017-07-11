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

// PhosphorRGB Chromaticities
//
// Color chromaticities are based on standards.  Monochrome chromaticities are
// taken from the PhosphorRGB Handbook.

// MONOCHROME

static const float2 PCOLOR = { 0.0f, 0.0f };
static const float2 P1 = { 0.218f, 0.712f };
static const float2 P3 = { 0.523f, 0.469f };
static const float2 P4 = { 0.265f, 0.285f };
static const float2 CHROMA_MONO[] = {
	PCOLOR,
	P1,
	P3,
	P4
};

// CONVERSIONS
static const float3 LUMA_REC_709 = { 0.2126f, 0.7152f, 0.0722f };

static const float3x3 SRGB_TO_SRGB = {
	1.0f, 0.0f, 0.0f,
        0.0f, 1.0f, 0.0f,
	0.0f, 0.0f, 1.0f
};
static const float3x3 SRGB_TO_NTSC_1953 = {
	0.6688f,  0.2650f,  0.0325f,
	0.0185f,  1.0795f, -0.0606f,
	0.0149f, -0.0309f,  0.8596f
};
static const float3x3 SRGB_TO_NTSC_1987 = {
	 1.0655f, -0.0554f, -0.0099f,
	-0.0198f,  1.0364f, -0.0167f,
	 0.0016f,  0.0044f,  0.9939f
};
static const float3x3 SRGB_TO_NTSC_J = {
	 1.2072f, -0.0628f, -0.0112f,
	-0.0200f,  1.0469f, -0.0169f,
	 0.0012f,  0.0032f,  0.7260f
};
static const float3x3 SRGB_TO_PAL_525 = {
	 1.0094f, -0.0525f, -0.0094f,
	-0.0204f,  1.0674f, -0.0173f,
	 0.0015f,  0.0040f,  0.9042f
};
static const float3x3 SRGB_TO_SECAM = {
	 0.9579f,  0.0421f, -0.0000f,
	-0.0001f,  1.0000f, -0.0000f,
	 0.0000f, -0.0119f,  1.0119f
};
static const float3x3 SRGB_TO_APPLE_RGB = {
	 0.9343f,  0.0768f, -0.0108f,
	-0.0232f,  1.0402f, -0.0167f,
	-0.0236f, -0.0340f,  1.0332f
};
static const float3x3 XYZ_TO_SRGB = {
	 3.2406f, -1.5372f, -0.4986f,
        -0.9689f,  1.8758f,  0.0415f,
	 0.0557f, -0.2040f,  1.0570f
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

static const float3x3 TO_ORIGINAL[] = {
	SRGB_TO_SRGB,
	SRGB_TO_NTSC_1953,
	SRGB_TO_NTSC_1987,
	SRGB_TO_NTSC_J,
	SRGB_TO_PAL_525,
	SRGB_TO_SECAM,
	SRGB_TO_APPLE_RGB
};

static const float3x3 TO_SRGB[] = {
	SRGB_TO_SRGB,
	NTSC_1953_TO_SRGB,
	NTSC_1987_TO_SRGB,
	NTSC_J_TO_SRGB,
	PAL_525_TO_SRGB,
	SECAM_TO_SRGB,
	APPLE_RGB_TO_SRGB
};

uniform float3 PhosphorRGB = { 0.0f, 0.0f, 0.0f };
uniform float PhosphorMono = 0.0f;
uniform float DeltaTime = 0.0f;
uniform int ColorSpace = 0;
uniform int PhosphorType = 0;

float4 ps_main(PS_INPUT Input) : COLOR
{
	const float4 CurrPix = tex2D(DiffuseSampler, Input.TexCoord);
	float3 PrevPix = tex2D(PreviousSampler, Input.PrevCoord).rgb;

	if (PhosphorType > 0 && PhosphorType <= 3)
	{
		float t = pow(100.0e3f, PhosphorMono) / 100.0e3f;
		float tau = -t / log(0.1f);
		const float x = CHROMA_MONO[PhosphorType][0];
		const float y = CHROMA_MONO[PhosphorType][1];
		float Y = dot(LUMA_REC_709, PrevPix);
		Y *= PhosphorMono == 0 ? 0 : exp(-DeltaTime / tau);
		const float X = x * (Y / y);
		const float Z = (1.0f - x - y) * (Y / y);
		PrevPix = mul(XYZ_TO_SRGB, float3(X, Y, Z));
	}
	else
	{
		float3 t = pow(float3(100.0e3f, 100.0e3f, 100.0e3f),
		               PhosphorRGB) / 100.0e3f;
		float3 tau = -t / log(0.1f);
		float3 RGB = mul(TO_ORIGINAL[ColorSpace], PrevPix);
		RGB.r *= PhosphorRGB.r == 0 ? 0 :
			exp(-DeltaTime / tau.r);
		RGB.g *= PhosphorRGB.g == 0 ? 0 :
			exp(-DeltaTime / tau.g);
		RGB.b *= PhosphorRGB.b == 0 ? 0 :
			exp(-DeltaTime / tau.b);
		PrevPix = mul(TO_SRGB[ColorSpace], RGB);
	}
	const float RedMax = max(CurrPix.r, PrevPix.r);
	const float GreenMax = max(CurrPix.g, PrevPix.g);
	const float BlueMax = max(CurrPix.b, PrevPix.b);

	return Passthrough ?
	       CurrPix : float4(RedMax, GreenMax, BlueMax, CurrPix.a);
}

//-----------------------------------------------------------------------------
// PhosphorRGB Technique
//-----------------------------------------------------------------------------

technique DefaultTechnique
{
	pass Pass0
	{
		Lighting = FALSE;
		SRGBWriteEnable = TRUE;

		VertexShader = compile vs_2_0 vs_main();
		PixelShader  = compile ps_2_0 ps_main();
	}
}
