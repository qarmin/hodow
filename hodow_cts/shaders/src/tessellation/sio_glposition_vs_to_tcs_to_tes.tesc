#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 3) out;


void main (void)
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    gl_TessLevelInner[0] = 2.0;
    gl_TessLevelInner[1] = 3.0;

    gl_TessLevelOuter[0] = 4.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 7.0;
}
