#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp texture1D u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture0, u_separateSampler0[1]), float(1.00781), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(0.0117188), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(0.363281), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[0]), float(-0.667969), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture1, u_separateSampler1[1]), float(1.00781), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
