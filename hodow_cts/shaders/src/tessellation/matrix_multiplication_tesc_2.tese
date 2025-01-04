#version 450
layout(quads, cw, fractional_odd_spacing) in;

layout(location = 5) patch in vec4 col0;

layout(location = 0) out vec4 col0_fs;

void main()
{
    col0_fs = col0;
    gl_Position = vec4(gl_TessCoord.xy * 2. - 1., 0, 1);
}
