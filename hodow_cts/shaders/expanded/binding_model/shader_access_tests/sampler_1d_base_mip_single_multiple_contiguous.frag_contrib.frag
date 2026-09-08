#version 440
layout(set = 0, binding = 0) uniform highp texture1D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(0.0234375), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(0.726562), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerA), float(-0.335938), 0.0);
    else
        result_color += textureLod(sampler1D(u_separateTexture, u_separateSamplerB), float(1.01562), 0.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
