#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_texture_buffer : require
layout(vertices=3) out;
layout(set = 0, binding = 32766, rgba8) uniform highp readonly imageBuffer u_texelBuffer0A;
layout(set = 0, binding = 65534, rgba8) uniform highp readonly imageBuffer u_texelBuffer0B;
layout(set = 2, binding = 32766, rgba8) uniform highp readonly imageBuffer u_texelBuffer1A;
layout(set = 2, binding = 65534, rgba8) uniform highp readonly imageBuffer u_texelBuffer1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
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

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
