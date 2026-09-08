#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp image2DArray u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image2DArray u_image1;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image0, ivec3(25, 25, 0));
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, ivec3(51, 40, 0));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, ivec3(42, 26, 1));
    else
        result_color += imageLoad(u_image1, ivec3(25, 25, 0));
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
