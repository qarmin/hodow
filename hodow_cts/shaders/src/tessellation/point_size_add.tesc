#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require
layout(vertices = 1) out;

void main (void)
{
    gl_TessLevelOuter[0] = 3.0;
    gl_TessLevelOuter[1] = 3.0;
    gl_TessLevelOuter[2] = 3.0;
    gl_TessLevelInner[0] = 3.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    // pass as is to eval
    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
