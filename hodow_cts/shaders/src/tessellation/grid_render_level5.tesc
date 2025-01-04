#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices = 1) out;

void main (void)
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    gl_TessLevelInner[0] = float(5);
    gl_TessLevelInner[1] = float(5);
    gl_TessLevelOuter[0] = float(5);
    gl_TessLevelOuter[1] = float(5);
    gl_TessLevelOuter[2] = float(5);
    gl_TessLevelOuter[3] = float(5);
}
