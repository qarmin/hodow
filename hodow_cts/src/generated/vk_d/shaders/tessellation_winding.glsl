#version 310 es

void main (void)
{
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

void main (void)
{
    gl_TessLevelInner[0] = 5.0;
    gl_TessLevelInner[1] = 5.0;

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, cw) in;

void main (void)
{
    gl_Position = vec4(gl_TessCoord.xy*2.0 - 1.0, 0.0, 1.0);
}
#version 310 es

layout(location = 0) out mediump vec4 o_color;

void main (void)
{
    o_color = vec4(1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, ccw) in;

void main (void)
{
    gl_Position = vec4(gl_TessCoord.xy*2.0 - 1.0, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, cw) in;

void main (void)
{
    gl_Position = vec4(gl_TessCoord.xy*2.0 - 1.0, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, ccw) in;

void main (void)
{
    gl_Position = vec4(gl_TessCoord.xy*2.0 - 1.0, 0.0, 1.0);
}
void main (void)
{
}
struct HS_CONSTANT_OUT
{
    float tessLevelsOuter[4] : SV_TessFactor;
    float tessLevelsInner[2] : SV_InsideTessFactor;
};

[domain("tri")]
[partitioning("integer")]
[outputtopology("triangle_cw")]
[outputcontrolpoints(1)]
[patchconstantfunc("PCF")]
void main()
{
}

HS_CONSTANT_OUT PCF()
{
    HS_CONSTANT_OUT output;
    output.tessLevelsInner[0] = 5.0;
    output.tessLevelsInner[1] = 5.0;
    output.tessLevelsOuter[0] = 5.0;
    output.tessLevelsOuter[1] = 5.0;
    output.tessLevelsOuter[2] = 5.0;
    output.tessLevelsOuter[3] = 5.0;
    return output;
}
float4 main(float3 tessCoords : SV_DOMAINLOCATION) : SV_POSITION
{
    return float4(tessCoords.xy*2.0 - 1, 0.0, 1.0);
}
float4 main (void) : COLOR0
{
    return float4(1.0);
}
struct HS_CONSTANT_OUT
{
    float tessLevelsOuter[4] : SV_TessFactor;
    float tessLevelsInner[2] : SV_InsideTessFactor;
};

[domain("tri")]
[partitioning("integer")]
[outputtopology("triangle_ccw")]
[outputcontrolpoints(1)]
[patchconstantfunc("PCF")]
void main()
{
}

HS_CONSTANT_OUT PCF()
{
    HS_CONSTANT_OUT output;
    output.tessLevelsInner[0] = 5.0;
    output.tessLevelsInner[1] = 5.0;
    output.tessLevelsOuter[0] = 5.0;
    output.tessLevelsOuter[1] = 5.0;
    output.tessLevelsOuter[2] = 5.0;
    output.tessLevelsOuter[3] = 5.0;
    return output;
}
struct HS_CONSTANT_OUT
{
    float tessLevelsOuter[4] : SV_TessFactor;
    float tessLevelsInner[2] : SV_InsideTessFactor;
};

[domain("quad")]
[partitioning("integer")]
[outputtopology("triangle_cw")]
[outputcontrolpoints(1)]
[patchconstantfunc("PCF")]
void main()
{
}

HS_CONSTANT_OUT PCF()
{
    HS_CONSTANT_OUT output;
    output.tessLevelsInner[0] = 5.0;
    output.tessLevelsInner[1] = 5.0;
    output.tessLevelsOuter[0] = 5.0;
    output.tessLevelsOuter[1] = 5.0;
    output.tessLevelsOuter[2] = 5.0;
    output.tessLevelsOuter[3] = 5.0;
    return output;
}
float4 main(float2 tessCoords : SV_DOMAINLOCATION) : SV_POSITION
{
    return float4(tessCoords.xy*2.0 - 1, 0.0, 1.0);
}
struct HS_CONSTANT_OUT
{
    float tessLevelsOuter[4] : SV_TessFactor;
    float tessLevelsInner[2] : SV_InsideTessFactor;
};

[domain("quad")]
[partitioning("integer")]
[outputtopology("triangle_ccw")]
[outputcontrolpoints(1)]
[patchconstantfunc("PCF")]
void main()
{
}

HS_CONSTANT_OUT PCF()
{
    HS_CONSTANT_OUT output;
    output.tessLevelsInner[0] = 5.0;
    output.tessLevelsInner[1] = 5.0;
    output.tessLevelsOuter[0] = 5.0;
    output.tessLevelsOuter[1] = 5.0;
    output.tessLevelsOuter[2] = 5.0;
    output.tessLevelsOuter[3] = 5.0;
    return output;
}
