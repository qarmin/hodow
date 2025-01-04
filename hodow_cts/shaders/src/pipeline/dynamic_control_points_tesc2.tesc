#version 450
layout(vertices = 4) out;
void main (void)
{
    gl_TessLevelInner[0] = 2;
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 2.0;
    gl_TessLevelOuter[2] = 2.0;
if (gl_InvocationID < 3) {    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
} else {    gl_out[gl_InvocationID].gl_Position = vec4(1.0, 0.0, 1.0, 1.0);}}
