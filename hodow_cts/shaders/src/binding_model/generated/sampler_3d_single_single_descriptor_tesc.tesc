#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp texture3D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler3D(u_separateTexture, u_separateSampler), vec3(float(0.0117188), float(0.0078125), float(0.191406)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler3D(u_separateTexture, u_separateSampler), vec3(float(0.363281), float(0.148438), float(1.25781)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler3D(u_separateTexture, u_separateSampler), vec3(float(-0.667969), float(1.32031), float(0.839844)), 0.0);
    else
        result_color += textureLod(sampler3D(u_separateTexture, u_separateSampler), vec3(float(1.00781), float(0.175781), float(1.30078)), 0.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
