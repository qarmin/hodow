#version 310 es
layout(set = 0, binding = 0, rgba8) readonly uniform highp image3D u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image3D u_image1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 18));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 17));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(19, 8, 12));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(10, 26, 19));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 18));
    result_color /= vec4(2.0);
    o_color = result_color;
}
