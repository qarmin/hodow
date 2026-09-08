#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 1) flat out highp int tes_quadrant_id[];
void main (void)
{
    tes_quadrant_id[gl_InvocationID] = tsc_quadrant_id[0];

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
