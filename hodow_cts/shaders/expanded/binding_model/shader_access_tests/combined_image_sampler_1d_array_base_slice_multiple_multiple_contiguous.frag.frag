#version 440
layout(set = 0, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp sampler1DArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp sampler1DArray u_combinedTextureSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec2(float(1.00781), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(0.0117188), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(0.363281), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec2(float(-0.667969), float(0)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec2(float(1.00781), float(0)), 0.0);
    result_color /= vec4(2.0);
    o_color = result_color;
}
