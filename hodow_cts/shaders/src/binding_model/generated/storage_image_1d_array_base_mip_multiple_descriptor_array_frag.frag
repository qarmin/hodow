#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1DArray u_image0[2];
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1DArray u_image1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0[1], ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0[0], ivec2(10, 0));
    else
        result_color += imageLoad(u_image0[1], ivec2(25, 1));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1[0], ivec2(6, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1[1], ivec2(19, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1[0], ivec2(10, 0));
    else
        result_color += imageLoad(u_image1[1], ivec2(25, 1));
    result_color /= vec4(2.0);
    o_color = result_color;
}
