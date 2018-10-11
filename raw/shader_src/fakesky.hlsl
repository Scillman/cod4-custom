
float4x4 viewProjectionMatrix : register(c0);
float4x4 worldMatrix : register(c4);

samplerCUBE skyMapSampler : register(s4);


struct VS_INPUT
{
    float4 position	: POSITION;
};

struct VS_OUTPUT
{
    float4 Pos	: POSITION;
    float3 T0	: TEXCOORD0;
};


VS_OUTPUT vs_main(VS_INPUT arg)
{
    VS_OUTPUT Out;
    float4 tmp0;
    float4 tmp1;
    float4 tmp2;

    tmp0 = 1;
    tmp0.xyz = mul(arg.position.xyz, 1);
    tmp1 = mul(tmp0, worldMatrix);
    tmp2 = mul(tmp1, viewProjectionMatrix);

    Out.Pos = tmp2;
    Out.T0.xyz = tmp1.xyz;
    return Out;
}

float4 ps_main(VS_OUTPUT arg) : COLOR
{
    float4 texColor = texCUBE(skyMapSampler, arg.T0);
    texColor.w = 0;
    return texColor;
}
