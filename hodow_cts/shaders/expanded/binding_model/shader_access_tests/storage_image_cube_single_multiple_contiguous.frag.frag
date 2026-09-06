#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCube u_imageA;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCube u_imageB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_imageA, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_imageB, ivec3(51, 40, 2));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_imageA, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_imageB, ivec3(25, 25, 0));
    o_color = result_color;
}
