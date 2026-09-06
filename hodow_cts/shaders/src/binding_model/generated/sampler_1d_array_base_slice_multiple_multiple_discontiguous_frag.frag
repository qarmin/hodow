#version 440
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp texture1DArray u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp texture1DArray u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture0, u_separateSampler0B), vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1A), vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(sampler1DArray(u_separateTexture1, u_separateSampler1B), vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
