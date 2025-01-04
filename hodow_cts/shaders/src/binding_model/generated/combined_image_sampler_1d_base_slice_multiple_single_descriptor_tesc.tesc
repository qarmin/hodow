#version 440
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp sampler1D u_combinedTextureSampler0;
layout(set = 1, binding = 0) uniform highp sampler1D u_combinedTextureSampler1;
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
        result_color += textureLod(u_combinedTextureSampler0, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, float(-0.667969), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, float(1.00781), 0.0);
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
