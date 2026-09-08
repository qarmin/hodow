#version 310 es
#extension GL_EXT_texture_buffer : require
layout(set = 0, binding = 0) uniform highp textureBuffer u_texelBuffer0[2];
layout(set = 1, binding = 0) uniform highp textureBuffer u_texelBuffer1[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += texelFetch(u_texelBuffer0[0], 6);
    else if (quadrant_id == 1)
        result_color += texelFetch(u_texelBuffer0[1], 51);
    else if (quadrant_id == 2)
        result_color += texelFetch(u_texelBuffer0[0], 42);
    else
        result_color += texelFetch(u_texelBuffer0[1], 25);
    if (quadrant_id == 0)
        result_color += texelFetch(u_texelBuffer1[0], 6);
    else if (quadrant_id == 1)
        result_color += texelFetch(u_texelBuffer1[1], 51);
    else if (quadrant_id == 2)
        result_color += texelFetch(u_texelBuffer1[0], 42);
    else
        result_color += texelFetch(u_texelBuffer1[1], 25);
    result_color /= vec4(2.0);
    o_color = result_color;
}
