// license:BSD-3-Clause
// copyright-holders:Westley M. Martinez
//-----------------------------------------------------------------------------
// Beam Deflection Expansion Effect
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Sampler Definitions
//-----------------------------------------------------------------------------

texture DiffuseTexture;
texture ExpandTextureR1;
texture ExpandTextureR2;

sampler DiffuseSampler = sampler_state {
	Texture = <DiffuseTexture>;
	MipFilter = LINEAR;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	AddressU = CLAMP;
	AddressV = CLAMP;
	AddressW = CLAMP;
};

sampler ExpandSamplerR1 = sampler_state {
        Texture = <ExpandTextureR1>;
	MipFilter = LINEAR;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	AddressU = CLAMP;
	AddressV = CLAMP;
	AddressW = CLAMP;
};

sampler ExpandSamplerR2 = sampler_state {
        Texture = <ExpandTextureR2>;
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
	float2 ExpandR1Coord : TEXCOORD1;
        float2 ExpandR2Coord : TEXCOORD2;
};

struct VS_INPUT
{
	float4 Position : POSITION;
	float4 Color : COLOR0;
	float2 TexCoord : TEXCOORD0;
};

struct PS_INPUT
{
	float4 Color : COLOR0;
	float2 TexCoord : TEXCOORD0;
	float2 ExpandR1Coord : TEXCOORD1;
        float2 ExpandR2Coord : TEXCOORD2;
};

//-----------------------------------------------------------------------------
// Expand Vertex Shader
//-----------------------------------------------------------------------------

uniform float2 ScreenDims;
uniform float2 TargetDims;

VS_OUTPUT vs_main(VS_INPUT Input)
{
	VS_OUTPUT Output = (VS_OUTPUT)0;

	Output.Position = float4(Input.Position.xyz, 1.0f);
	Output.Position.xy /= ScreenDims;
	Output.Position.y = 1.0f - Output.Position.y; // flip y
	Output.Position.xy -= 0.5f; // center
	Output.Position.xy *= 2.0f; // zoom

	Output.Color = Input.Color;

	Output.TexCoord = Input.TexCoord;
	Output.TexCoord += 0.5f / TargetDims; // half texel offset correction (DX9)

        Output.ExpandR1Coord = Output.TexCoord;
        Output.ExpandR2Coord = Output.TexCoord;

	return Output;
}

//-----------------------------------------------------------------------------
// Expand Pixel Shader
//-----------------------------------------------------------------------------

static const float kernel_r1[] = { 0.9545f, 0.02275f };
static const float offset_r1[] = { 0.0f, 1.0f };
static const float kernel_r2[] = { 0.383103f, 0.241843f, 0.060626f, 0.00598f };
static const float offset_r2[] = { 0.0f, 1.0f, 2.0f, 3.0f };

float4 ps_gamma(PS_INPUT Input) : COLOR
{
        float3 esample = pow(tex2D(DiffuseSampler, Input.TexCoord).rgb, 4.0f);

        return float4(esample, 1.0f);
}

float4 ps_vertical_r1(PS_INPUT Input) : COLOR
{
        float3 esample = tex2D(DiffuseSampler, Input.TexCoord).rgb * kernel_r1[0];
        for (int i = 1; i < 2; ++i) {
                float2 offset = float2(0.0f, offset_r1[i]) / 512.0f;
                esample += tex2D(DiffuseSampler, Input.TexCoord + offset).rgb * kernel_r1[i];
                esample += tex2D(DiffuseSampler, Input.TexCoord - offset).rgb * kernel_r1[i];
        }
	return float4(esample, 1.0f);
}

float4 ps_horizontal_r1(PS_INPUT Input) : COLOR
{
        float3 esample = tex2D(DiffuseSampler, Input.TexCoord).rgb * kernel_r1[0];
        for (int i = 1; i < 2; ++i) {
                float2 offset = float2(offset_r1[i], 0.0f) / 512.0f;
                esample += tex2D(DiffuseSampler, Input.TexCoord + offset).rgb * kernel_r1[i];
                esample += tex2D(DiffuseSampler, Input.TexCoord - offset).rgb * kernel_r1[i];
        }
	return float4(esample, 1.0f);
}

float4 ps_vertical_r2(PS_INPUT Input) : COLOR
{
        float3 esample = tex2D(DiffuseSampler, Input.TexCoord).rgb * kernel_r2[0];
        for (int i = 1; i < 4; ++i) {
                float2 offset = float2(0.0f, offset_r2[i]) / 512.0f;
                esample += tex2D(DiffuseSampler, Input.TexCoord + offset).rgb * kernel_r2[i];
                esample += tex2D(DiffuseSampler, Input.TexCoord - offset).rgb * kernel_r2[i];
        }
	return float4(esample, 1.0f);
}

float4 ps_horizontal_r2(PS_INPUT Input) : COLOR
{
        float3 esample = tex2D(DiffuseSampler, Input.TexCoord).rgb * kernel_r2[0];
        for (int i = 1; i < 4; ++i) {
                float2 offset = float2(offset_r2[i], 0.0f) / 512.0f;
                esample += tex2D(DiffuseSampler, Input.TexCoord + offset).rgb * kernel_r2[i];
                esample += tex2D(DiffuseSampler, Input.TexCoord - offset).rgb * kernel_r2[i];
        }
	return float4(esample, 1.0f);
}

float4 ps_difference(PS_INPUT Input) : COLOR
{
        float3 r1 = tex2D(ExpandSamplerR1, Input.ExpandR1Coord).rgb;
        float3 r2 = tex2D(ExpandSamplerR2, Input.ExpandR2Coord).rgb;
        float3 osample = tex2D(DiffuseSampler, Input.TexCoord).rgb;

        osample = 1.0f - (1.0f - r2 - r1) * (1.0f - osample);
        return float4(osample, 1.0f);
}

//-----------------------------------------------------------------------------
// Expand Technique
//-----------------------------------------------------------------------------

technique GammaTechnique
{
        pass Pass0
        {
                Lighting = FALSE;

                VertexShader = compile vs_3_0 vs_main();
                PixelShader = compile ps_3_0 ps_gamma();
        }
}

technique VerticalTechniqueR1
{
	pass Pass0
	{
		Lighting = FALSE;

		VertexShader = compile vs_3_0 vs_main();
		PixelShader = compile ps_3_0 ps_vertical_r1();
	}
}

technique HorizontalTechniqueR1
{
        pass Pass0
        {
                Lighting = FALSE;

                VertexShader = compile vs_3_0 vs_main();
                PixelShader = compile ps_3_0 ps_horizontal_r1();
        }
}

technique VerticalTechniqueR2
{
        pass Pass0
	{
		Lighting = FALSE;

		VertexShader = compile vs_3_0 vs_main();
		PixelShader = compile ps_3_0 ps_vertical_r2();
	}
}

technique HorizontalTechniqueR2
{
        pass Pass0
        {
                Lighting = FALSE;

                VertexShader = compile vs_3_0 vs_main();
                PixelShader = compile ps_3_0 ps_horizontal_r2();
        }
}

technique DifferenceTechnique
{
        pass Pass0
        {
                Lighting = FALSE;

                VertexShader = compile vs_3_0 vs_main();
                PixelShader = compile ps_3_0 ps_difference();
        }
}