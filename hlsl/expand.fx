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

static const float kernel_r1[] = { 0.684538f, 0.157731f };
static const float offset_r1[] = { 0.0f, 1.0f };
static const float kernel_r2[] = { 0.261824f, 0.211357f, 0.111165f, 0.038078f, 0.008488f };
static const float offset_r2[] = { 0.0f, 1.0f, 2.0f, 3.0f, 4.0f };

uniform int Mode = 0;
uniform float Alpha = 0.0f;
uniform float Gamma = 0.0f;
uniform float2 Radius = { 0.0f, 0.0f };

float4 ps_gamma(PS_INPUT Input) : COLOR
{
        float3 esample = pow(tex2D(DiffuseSampler, Input.TexCoord).rgb, Gamma);

        return float4(esample, 1.0f);
}

float4 ps_vertical_r1(PS_INPUT Input) : COLOR
{
        float3 esample = tex2D(DiffuseSampler, Input.TexCoord).rgb * kernel_r1[0];
        for (int i = 1; i < 2; ++i) {
                float2 offset = Radius[1] * float2(0.0f, offset_r1[i]) / 512.0f;
                esample += tex2D(DiffuseSampler, Input.TexCoord + offset).rgb * kernel_r1[i];
                esample += tex2D(DiffuseSampler, Input.TexCoord - offset).rgb * kernel_r1[i];
        }
	return float4(esample, 1.0f);
}

float4 ps_horizontal_r1(PS_INPUT Input) : COLOR
{
        float3 esample = tex2D(DiffuseSampler, Input.TexCoord).rgb * kernel_r1[0];
        for (int i = 1; i < 2; ++i) {
                float2 offset = Radius[0] * float2(offset_r1[i], 0.0f) / 512.0f;
                esample += tex2D(DiffuseSampler, Input.TexCoord + offset).rgb * kernel_r1[i];
                esample += tex2D(DiffuseSampler, Input.TexCoord - offset).rgb * kernel_r1[i];
        }
	return float4(esample, 1.0f);
}

float4 ps_vertical_r2(PS_INPUT Input) : COLOR
{
        float3 esample = tex2D(DiffuseSampler, Input.TexCoord).rgb * kernel_r2[0];
        for (int i = 1; i < 5; ++i) {
                float2 offset = Radius[1] * float2(0.0f, offset_r2[i]) / 512.0f;
                esample += tex2D(DiffuseSampler, Input.TexCoord + offset).rgb * kernel_r2[i];
                esample += tex2D(DiffuseSampler, Input.TexCoord - offset).rgb * kernel_r2[i];
        }
	return float4(esample, 1.0f);
}

float4 ps_horizontal_r2(PS_INPUT Input) : COLOR
{
        float3 esample = tex2D(DiffuseSampler, Input.TexCoord).rgb * kernel_r2[0];
        for (int i = 1; i < 5; ++i) {
                float2 offset = Radius[0] * float2(offset_r2[i], 0.0f) / 512.0f;
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
        float3 result;

        if (!Mode) {
                result = 1.0f - (1.0f - Alpha * (r2 - r1)) * (1.0f - osample);
                osample = lerp(osample, result, float3(Alpha, Alpha, Alpha));
        }
        else {
                result = osample * osample + 2.0f * (1.0f - Alpha) * (r2 - r1) * (1.0f - osample);
                osample = lerp(osample, result, float3(Alpha, Alpha, Alpha));
        }
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