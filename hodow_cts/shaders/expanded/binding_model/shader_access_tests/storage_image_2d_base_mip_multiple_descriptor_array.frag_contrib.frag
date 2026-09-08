#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2D u_image1[2];
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec2(10, 26));
    else
        result_color += imageLoad(u_image0[1], ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec2(19, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec2(10, 26));
    else
        result_color += imageLoad(u_image1[1], ivec2(25, 25));
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
