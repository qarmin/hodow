#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(xfb_buffer = 0, xfb_offset = 0, location = 0) out vec4 out0;
void main (void)
{
    out0 = vec4(42);
    vec4 p0 = gl_TessCoord.x * gl_in[0].gl_Position;
    vec4 p1 = gl_TessCoord.y * gl_in[1].gl_Position;
    vec4 p2 = gl_TessCoord.z * gl_in[2].gl_Position;
    gl_Position = p0 + p1 + p2;
}
