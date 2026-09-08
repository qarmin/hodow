#version 310 es
layout(set = 0, binding = 0) uniform highp sampler2D u_combinedTextureSampler0;
layout(set = 2, binding = 0) uniform highp sampler2D u_combinedTextureSampler1;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0, vec2(float(1.00781), float(0.175781)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.0117188), float(0.0078125)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(0.363281), float(0.148438)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(-0.667969), float(1.32031)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1, vec2(float(1.00781), float(0.175781)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
