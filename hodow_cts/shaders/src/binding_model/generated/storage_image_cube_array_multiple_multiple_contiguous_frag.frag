#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image0A;
layout(set = 0, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image0B;
layout(set = 1, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image1A;
layout(set = 1, binding = 1, rgba8) readonly uniform highp imageCubeArray u_image1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image0B, ivec3(25, 25, 6));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1A, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1B, ivec3(51, 40, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1A, ivec3(42, 26, 7));
    else
        result_color += imageLoad(u_image1B, ivec3(25, 25, 6));
    result_color /= vec4(2.0);
    o_color = result_color;
}
