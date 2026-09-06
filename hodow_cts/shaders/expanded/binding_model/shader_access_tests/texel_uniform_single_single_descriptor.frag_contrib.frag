#version 310 es
#extension GL_EXT_texture_buffer : require
layout(set = 0, binding = 0) uniform highp textureBuffer u_texelBuffer;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += texelFetch(u_texelBuffer, 6);
    else if (quadrant_id == 1)
        result_color += texelFetch(u_texelBuffer, 51);
    else if (quadrant_id == 2)
        result_color += texelFetch(u_texelBuffer, 42);
    else
        result_color += texelFetch(u_texelBuffer, 25);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
