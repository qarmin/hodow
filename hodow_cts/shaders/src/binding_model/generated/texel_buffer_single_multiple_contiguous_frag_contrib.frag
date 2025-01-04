#version 310 es
#extension GL_EXT_texture_buffer : require
layout(set = 0, binding = 0, rgba8) uniform highp readonly imageBuffer u_texelBufferA;
layout(set = 0, binding = 1, rgba8) uniform highp readonly imageBuffer u_texelBufferB;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_texelBufferA, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_texelBufferB, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_texelBufferA, 42);
    else
        result_color += imageLoad(u_texelBufferB, 25);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
