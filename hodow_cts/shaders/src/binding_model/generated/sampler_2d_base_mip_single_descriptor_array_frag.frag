#version 310 es
layout(set = 0, binding = 0) uniform highp texture2D u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(sampler2D(u_separateTexture, u_separateSampler[0]), vec2(float(0.0234375), float(0.015625)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(sampler2D(u_separateTexture, u_separateSampler[1]), vec2(float(0.726562), float(0.296875)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(sampler2D(u_separateTexture, u_separateSampler[0]), vec2(float(-0.335938), float(1.64062)), 0.0);
    else
        result_color += textureLod(sampler2D(u_separateTexture, u_separateSampler[1]), vec2(float(1.01562), float(0.351562)), 0.0);
    o_color = result_color;
}
