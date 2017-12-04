// license:BSD-3-Clause
// copyright-holders:Ryan Holtz, Westley M. Martinez
//-----------------------------------------------------------------------------
// Color-Convolution Effect
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
};

struct VS_INPUT
{
	float4 Position : POSITION;
	float4 Color : COLOR0;
	float2 TexCoord : TEXCOORD0;
	float2 Unused : TEXCOORD1;
};

struct PS_INPUT
{
	float4 Color : COLOR0;
	float2 TexCoord : TEXCOORD0;
};

//-----------------------------------------------------------------------------
// Color-Convolution Vertex Shader
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
// Color-Convolution Pixel Shader
//-----------------------------------------------------------------------------

static const float3x3 RGB_TO_YPBPR = {
	 0.299f,  0.587f,  0.114f,
	-0.299f, -0.587f,  0.886f,
	 0.701f, -0.587f, -0.114f,
};

static const float3x3 YPBPR_TO_RGB = {
	1.000f,  0.000f,  1.000f,
	1.000f, -0.194f, -0.509f,
	1.000f,  1.000f,  0.000f
};

uniform int ColorSpace = 0;
uniform float3 RedRatios = float3(1.0f, 0.0f, 0.0f);
uniform float3 GrnRatios = float3(0.0f, 1.0f, 0.0f);
uniform float3 BluRatios = float3(0.0f, 0.0f, 1.0f);
uniform float3 Offset = float3(0.0f, 0.0f, 0.0f);
uniform float3 Scale = float3(1.0f, 1.0f, 1.0f);
uniform float Saturation = 1.0f;
uniform float Tint = 0.0f;

float4 ps_main(PS_INPUT Input) : COLOR
{
	float4 BaseTexel = tex2D(DiffuseSampler, Input.TexCoord);

	float3 OutRGB = BaseTexel.rgb;

	// Saturation & Tint
	if (Saturation != 1.0f || Tint != 0.0f) {
		float3 OutYPbPr = mul(RGB_TO_YPBPR, OutRGB);
		float r = length(OutYPbPr.yz);
		float theta = atan2(OutYPbPr.z, OutYPbPr.y);
		r *= Saturation;
		theta += radians(Tint);
		OutYPbPr.y = r * cos(theta);
		OutYPbPr.z = r * sin(theta);
		OutRGB = clamp(mul(YPBPR_TO_RGB, OutYPbPr), 0.0f, 1.0f);
	}

	// RGB Scale & Offset
	float3 OutTexel = Scale * OutRGB + Offset;

	// Arbitrary Color Matrix
	float3x3 RatioMatrix = {
		RedRatios,
		GrnRatios,
		BluRatios
	};
	OutRGB = mul(RatioMatrix, OutRGB);

	return float4(OutTexel, BaseTexel.a);
}

//-----------------------------------------------------------------------------
// Color-Convolution Technique
//-----------------------------------------------------------------------------

technique DefaultTechnique
{
	pass Pass0
	{
		Lighting = FALSE;

		VertexShader = compile vs_3_0 vs_main();
		PixelShader  = compile ps_3_0 ps_main();
	}
}
