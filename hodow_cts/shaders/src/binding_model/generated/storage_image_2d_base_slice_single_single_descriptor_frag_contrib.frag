#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image, ivec2(42, 26));
    else
        result_color += imageLoad(u_image, ivec2(25, 25));
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
