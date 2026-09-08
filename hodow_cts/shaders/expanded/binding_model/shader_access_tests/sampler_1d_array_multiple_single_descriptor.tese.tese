#version 440
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0;
layout(set = 1, binding = 0) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1;
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(-0.667969), float(1)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
