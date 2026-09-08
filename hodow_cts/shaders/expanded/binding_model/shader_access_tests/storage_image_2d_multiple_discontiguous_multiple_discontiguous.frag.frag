#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2D u_image0A;
layout(set = 0, binding = 2, rgba8) readonly uniform highp image2D u_image0B;
layout(set = 2, binding = 0, rgba8) readonly uniform highp image2D u_image1A;
layout(set = 2, binding = 2, rgba8) readonly uniform highp image2D u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image0B, ivec2(25, 25));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec2(6, 13));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec2(51, 40));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec2(42, 26));
    else
        result_color += imageLoad(u_image1B, ivec2(25, 25));
    result_color /= vec4(2.0);
    o_color = result_color;
}
