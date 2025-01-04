#version 310 es

void main (void)
{
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(set = 0, binding = 0, std430) readonly restrict buffer TessLevels {
    float outer1;
} sb_levels;

void main (void)
{
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = sb_levels.outer1;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, fractional_odd_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) restrict buffer Results {
    float data[];
} sb_out_tessCoord;
layout(set = 0, binding = 2, std430) coherent restrict buffer Counter {
    int   data;
} sb_out_numInvocations;

void main (void)
{
    int index = atomicAdd(sb_out_numInvocations.data, 1);
    sb_out_tessCoord.data[index] = gl_TessCoord.x;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(isolines, fractional_odd_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) restrict buffer Results {
    float data[];
} sb_out_tessCoord;
layout(set = 0, binding = 2, std430) coherent restrict buffer Counter {
    int   data;
} sb_out_numInvocations;

void main (void)
{
    int index = atomicAdd(sb_out_numInvocations.data, 1);
    sb_out_tessCoord.data[index] = gl_TessCoord.x;
    gl_PointSize = 1.0f;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, fractional_even_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) restrict buffer Results {
    float data[];
} sb_out_tessCoord;
layout(set = 0, binding = 2, std430) coherent restrict buffer Counter {
    int   data;
} sb_out_numInvocations;

void main (void)
{
    int index = atomicAdd(sb_out_numInvocations.data, 1);
    sb_out_tessCoord.data[index] = gl_TessCoord.x;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(isolines, fractional_even_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) restrict buffer Results {
    float data[];
} sb_out_tessCoord;
layout(set = 0, binding = 2, std430) coherent restrict buffer Counter {
    int   data;
} sb_out_numInvocations;

void main (void)
{
    int index = atomicAdd(sb_out_numInvocations.data, 1);
    sb_out_tessCoord.data[index] = gl_TessCoord.x;
    gl_PointSize = 1.0f;
}
void main (void)
{
}
struct HS_CONSTANT_OUT
{
    float tessLevelsOuter[2] : SV_TessFactor;
};

tbuffer TessLevels : register(b0)
{
    float outer1;
}

[domain("isoline")]
[partitioning("fractional_odd")]
[outputtopology("point")]
[outputcontrolpoints(1)]
[patchconstantfunc("PCF")]
void main()
{
}

HS_CONSTANT_OUT PCF()
{
    HS_CONSTANT_OUT output;
    output.tessLevelsOuter[0] = 1.0;
    output.tessLevelsOuter[1] = outer1;
    return output;
}
RWStructuredBuffer <float> tessCoord : register(b1);
globallycoherent RWStructuredBuffer <int> numInvocations : register(b2);

void main(float2 tessCoords : SV_DOMAINLOCATION)
{
    int index;
    InterlockedAdd(numInvocations[0], 1, index);
    tessCoord[index] = tessCoords.x;
}
struct HS_CONSTANT_OUT
{
    float tessLevelsOuter[2] : SV_TessFactor;
};

tbuffer TessLevels : register(b0)
{
    float outer1;
}

[domain("isoline")]
[partitioning("fractional_even")]
[outputtopology("point")]
[outputcontrolpoints(1)]
[patchconstantfunc("PCF")]
void main()
{
}

HS_CONSTANT_OUT PCF()
{
    HS_CONSTANT_OUT output;
    output.tessLevelsOuter[0] = 1.0;
    output.tessLevelsOuter[1] = outer1;
    return output;
}
