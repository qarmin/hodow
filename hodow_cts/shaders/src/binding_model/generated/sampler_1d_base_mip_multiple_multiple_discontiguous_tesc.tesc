#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0B), float(1.01562), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1A), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1B), float(1.01562), 0.0);
    result_color /= vec4(2.0);

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
