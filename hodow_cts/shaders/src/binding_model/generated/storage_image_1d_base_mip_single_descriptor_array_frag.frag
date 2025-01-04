#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], 19);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], 10);
    else
        result_color += imageLoad(u_image[1], 25);
    o_color = result_color;
}
