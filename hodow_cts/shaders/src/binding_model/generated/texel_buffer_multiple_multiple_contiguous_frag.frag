#version 310 es
#extension GL_EXT_texture_buffer : require
layout(set = 0, binding = 0, rgba8) uniform highp readonly imageBuffer u_texelBuffer0A;
layout(set = 0, binding = 1, rgba8) uniform highp readonly imageBuffer u_texelBuffer0B;
layout(set = 1, binding = 0, rgba8) uniform highp readonly imageBuffer u_texelBuffer1A;
layout(set = 1, binding = 1, rgba8) uniform highp readonly imageBuffer u_texelBuffer1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_texelBuffer0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_texelBuffer0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_texelBuffer0A, 42);
    else
        result_color += imageLoad(u_texelBuffer0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_texelBuffer1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_texelBuffer1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_texelBuffer1A, 42);
    else
        result_color += imageLoad(u_texelBuffer1B, 25);
    result_color /= vec4(2.0);
    o_color = result_color;
}
