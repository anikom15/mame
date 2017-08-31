// license:BSD-3-Clause
// copyright-holders:Westley M. Martinez
//-----------------------------------------------------------------------------
// Input Gamma Correction
//-----------------------------------------------------------------------------

// This shader reads RGB data, either directly from the system's output or
// converted from another color space by the conventional methods, and applies
// gamma decoding to linear space.
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
// should be set to sRGB Mode (ideal) or set to 2.2 (CRT monitors).  For
// Macintosh before OS X 10.6, use 1.8.  Gamma for older LCDs is not well
// defined and can only be approximated.  The Game Boy Advance's LCD has a
// gamma around 3 when well lit and viewed directly, while modern backlit LCDs
// have gammas similar to CRTs.
//
// It is interesting and important to note that sRGB's gamma encoding is
// nontrivial.  It is not a simple 2.2 encoding curve, though that may be used
// for a fast approximation.  A faster approximation for sRGB and video uses a
// gamma of 2.0.  That speedy technique is not implemented here.
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

uniform float Gain = 1.0f;
uniform float BlackLevel = 0.0f;
uniform float Gamma = 1.0f;

float4 ps_main(PS_INPUT Input) : COLOR
{
	const float4 BaseTexel = tex2D(DiffuseSampler, Input.TexCoord);

	float3 OutRGB = Gain * pow(max(BaseTexel.rgb + BlackLevel,
	                               float3(0.0f, 0.0f, 0.0f)),
	                           float3(Gamma, Gamma, Gamma));
	return float4(OutRGB, BaseTexel.a);
}

//-----------------------------------------------------------------------------
// Gamma Technique
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
