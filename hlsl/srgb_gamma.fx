// license:BSD-3-Clause
// copyright-holders:Westley M. Martinez
//-----------------------------------------------------------------------------
// Special sRGB Gamma Correction
//-----------------------------------------------------------------------------

// See gamma.fx for detailed information about screen gamma.

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
// sRGB Gamma Vertex Shader
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
// sRGB Gamma Pixel Shader
//-----------------------------------------------------------------------------

float4 ps_main(PS_INPUT Input) : COLOR
{
	const float4 BaseTexel = tex2D(DiffuseSampler, Input.TexCoord);

        return BaseTexel;
}

//-----------------------------------------------------------------------------
// sRGB Gamma Technique
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
