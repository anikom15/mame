// license:BSD-3-Clause
// copyright-holders:Westley M. Martinez
//-----------------------------------------------------------------------------
// Color Correction Effect
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
// Color Correction Vertex Shader
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
// Color Correction Pixel Shader
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
static const float NTSC_1953_OFFSET = 0.4557f;
static const float NTSC_1953_COMPRESSION = 1.5073f;
static const float3x3 NTSC_1987_TO_SRGB = {
	 0.9394f,  0.0502f, 0.0102f,
         0.0179f,  0.9658f, 0.0164f,
	-0.0016f, -0.0044f, 1.0060f
};
static const float NTSC_1987_OFFSET = 0.0060f;
static const float NTSC_1987_COMPRESSION = 1.0001f;
static const float3x3 NTSC_J_TO_SRGB = {
	 0.8292f,  0.0497f, 0.0140f,
         0.0158f,  0.9561f, 0.0225f,
	-0.0014f, -0.0043f, 1.3772f
};
static const float NTSC_J_OFFSET = 0.0057f;
static const float NTSC_J_COMPRESSION = 1.3772f;
static const float3x3 PAL_525_TO_SRGB = {
	 0.9917f,  0.0487f, 0.0112f,
         0.0189f,  0.9377f, 0.0181f,
	-0.0017f, -0.0042f, 1.1058f
};
static const float PAL_525_OFFSET = 0.0059f;
static const float PAL_525_COMPRESSION = 1.1058f;
static const float3x3 SECAM_TO_SRGB = {
	1.0439f, -0.0440f, -0.0000f,
        0.0001f,  1.0000f, -0.0000f,
	0.0000f,  0.0118f,  0.9882f
};
static const float SECAM_OFFSET = 0.0440f;
static const float SECAM_COMPRESSION = 1.0439f;
static const float3x3 APPLE_RGB_TO_SRGB = {
	1.0686f, -0.0786f, 0.0099f,
        0.0242f,  0.9601f, 0.0158f,
	0.0252f,  0.0298f, 0.9686f
};
static const float APPLE_RGB_OFFSET = 0.0786f;
static const float APPLE_RGB_COMPRESSION = 1.0785f;
static const float3x3 CORRECTION_MATRIX[] = {
	SRGB_TO_SRGB,
	NTSC_1953_TO_SRGB,
	NTSC_1987_TO_SRGB,
	NTSC_J_TO_SRGB,
	PAL_525_TO_SRGB,
	SECAM_TO_SRGB,
	APPLE_RGB_TO_SRGB
};
static const float OFFSET[] = {
	0.0f,
	NTSC_1953_OFFSET,
	NTSC_1987_OFFSET,
	NTSC_J_OFFSET,
	PAL_525_OFFSET,
	SECAM_OFFSET,
	APPLE_RGB_OFFSET
};
static const float COMPRESSION[] = {
	1.0f,
	NTSC_1953_COMPRESSION,
	NTSC_1987_COMPRESSION,
	NTSC_J_COMPRESSION,
	PAL_525_COMPRESSION,
	SECAM_COMPRESSION,
	APPLE_RGB_COMPRESSION
};

uniform int ColorSpace = 0;

float4 ps_main(PS_INPUT Input) : COLOR
{
	const float4 BaseColor = tex2D(DiffuseSampler, Input.TexCoord);
        float3 OutRGB = BaseColor.rgb;

	OutRGB = ColorSpace <= 6 ?
		 mul(CORRECTION_MATRIX[ColorSpace], OutRGB) :
		 OutRGB;
	return float4(OutRGB, BaseColor.a);
}

//-----------------------------------------------------------------------------
// Color Correction Technique
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
