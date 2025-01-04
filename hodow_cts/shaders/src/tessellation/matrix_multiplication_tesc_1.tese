#version 450
layout(quads, cw, fractional_odd_spacing) in;

layout(location = 0) patch in mat4 x;
layout(location = 0) out mat4 x_fs;

void main()
{
    x_fs = x;
    gl_Position = vec4(gl_TessCoord.xy * 2. - 1., 0, 1);
}
