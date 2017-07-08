// license:BSD-3-Clause
// copyright-holders:Westley M. Martinez
//-----------------------------------------------------------------------------
// Input Gamma Correction
//-----------------------------------------------------------------------------

// This shader reads RGB data, either directly from the system's output or
// converted from another color space by the conventional methods, and applies
// gamma decoding to linear space.  Since we are using 8-bit textures, it
// writes sRGB data.
//
// Gamma encoding information is generally not carried in video signals, and
// gamma correction is done by known convention.  Three common conventions are
// BT.1886 - a standard for describing the behavior of real CRTs,
// sRGB - a nontrivial decoding method,
// Macintosh - Macs before OS X 10.6 used a decoding value of 1.8.
// BT.1886 was developed in the HD era.  A gamma decoding value of 2.40 was
// chosen, but actual CRT behavior varies.  Thus 2.4 is the default chosen
// for this shader. Content that 'expects' a 2.4 decoding curve will be
// referred to as simply 'video'.
//
// For most emulated systems, a value around 2.4 or 2.2 should be acceptable.
// For emulating post-1995 PC systems, including Windows, the gamma correction
// should be set to off (ideal) or set to 2.2 (CRT monitors).  For Macintosh
// before OS X 10.6, use 1.8.
//
// It is interesting and important to note that sRGB's gamma encoding is
// nontrivial.  It is not a simple 2.2 encoding curve, though that may be used
// for a fast approximation.  A faster approximation for sRGB and video uses a
// gamma of 2.0.
//
// Note that gamma operations are never applied to alpha channels.  Alpha is
// always asssumed to be linear, even for 8-bit textures.

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
};

//-----------------------------------------------------------------------------
// Gamma Vertex Shader
//-----------------------------------------------------------------------------

uniform float2 ScreenDims;
uniform float2 SourceDims;

VS_OUTPUT vs_main(VS_INPUT Input)
{
	VS_OUTPUT Output = (VS_OUTPUT)0;

	Output.Position = float4(Input.Position.xyz, 1.0f);
	Output.Position.xy /= ScreenDims;
	Output.Position.y = 1.0f - Output.Position.y; // flip y
	Output.Position.xy -= 0.5f; // center
	Output.Position.xy *= 2.0f; // zoom

	Output.TexCoord = Input.TexCoord;
	Output.TexCoord += 0.5f / SourceDims; // half texel offset correction (DX9)

	Output.Color = Input.Color;

	return Output;
}

//-----------------------------------------------------------------------------
// Gamma Pixel Shader
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
// white D65.

static const float3x3 SRGB_TO_SRGB = { 1.0f, 0.0f, 0.0f,
                                       0.0f, 1.0f, 0.0f,
				       0.0f, 0.0f, 1.0f
                                     };

static const float3x3 NTSC_1953_TO_SRGB = {  1.5073f, -0.3724f, -0.0833f,
                                            -0.0273f,  0.9350f,  0.0669f,
                                            -0.0271f,  0.0401f,  1.1672f
                                          };
static const float3x3 NTSC_1987_TO_SRGB = {  0.9394f,  0.0502f, 0.0102f,
                                             0.0179f,  0.9658f, 0.0164f,
					    -0.0016f, -0.0044f, 1.0060f
                                          };
static const float3x3 NTSC_J_TO_SRGB = {  0.8292f,  0.0497f, 0.0140f,
                                          0.0158f,  0.9561f, 0.0225f,
					 -0.0014f, -0.0043f, 1.3772f
                                       };
static const float3x3 PAL_525_TO_SRGB = {  0.9917f,  0.0487f, 0.0112f,
                                           0.0189f,  0.9377f, 0.0181f,
					  -0.0017f, -0.0042f, 1.1058f
                                        };
static const float3x3 SECAM_TO_SRGB = { 1.0439f, -0.0440f, -0.0000f,
                                        0.0001f,  1.0000f, -0.0000f,
					0.0000f,  0.0118f,  0.9882f
                                      };
static const float3x3 APPLE_RGB_TO_SRGB = { 1.0686f, -0.0786f, 0.0099f,
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
static const float3 LUMA_REC_709 = { 0.2126f, 0.7152f, 0.0722f };
static const float3x3 XYZ_TO_SRGB = {  3.2406f, -1.5372f, -0.4986f,
                                      -0.9689f,  1.8758f,  0.0415f,
				       0.0557f, -0.2040f,  1.0570f
                                    };
static const float2 PCOLOR = { 0.0f, 0.0f };
static const float2 P1 = { 0.218f, 0.712f };
static const float2 P3 = { 0.523f, 0.469f };
static const float2 P4 = { 0.265f, 0.285f };
static const float2 PHOSPHOR[] = {
	PCOLOR,
	P1,
	P3,
	P4
};

uniform float Gamma = 1.0f;
uniform int ColorSpace = 0;
uniform int PhosphorType = 0;

float4 ps_main(PS_INPUT Input) : COLOR
{
	float4 BaseTexel = tex2D(DiffuseSampler, Input.TexCoord);

	float3 OutRGB = pow(BaseTexel.rgb, float3(Gamma, Gamma, Gamma));
	OutRGB = ColorSpace <= 6 ?
	         mul(CORRECTION_MATRIX[ColorSpace], OutRGB) :
		 OutRGB;
	if (PhosphorType > 0 && PhosphorType <= 3)
	{
		float x = PHOSPHOR[PhosphorType][0];
		float y = PHOSPHOR[PhosphorType][1];
		float Y = dot(LUMA_REC_709, OutRGB);
		float X = x * (Y / y);
		float Z = (1.0f - x - y) * (Y / y);
		OutRGB = mul(XYZ_TO_SRGB, float3(X, Y, Z));
	}
	return float4(OutRGB, BaseTexel.a);
}

//-----------------------------------------------------------------------------
// Gamma Technique
//-----------------------------------------------------------------------------

technique DefaultTechnique
{
	pass Pass0
	{
		// 8-bit textures should be written in sRGB to reduce banding
		Lighting = FALSE;
		SRGBWriteEnable = TRUE;

		VertexShader = compile vs_2_0 vs_main();
		PixelShader  = compile ps_2_0 ps_main();
	}
}
