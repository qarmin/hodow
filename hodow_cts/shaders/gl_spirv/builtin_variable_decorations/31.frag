#version 450

layout (location = 1) in vec4 vColor;
layout (location = 0) out vec4 fColor;

void main()
{
    vec4 color = vColor;
    vec2 coord = gl_PointCoord;
color.b = coord.s * coord.t;

    fColor = color;
}
