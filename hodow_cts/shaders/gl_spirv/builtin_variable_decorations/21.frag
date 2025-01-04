#version 450

layout (location = 1) in vec4 vColor;
layout (location = 0) out vec4 fColor;

void main()
{
    vec4 color = vColor;
    vec4 coord = gl_FragCoord;
color = vec4(0.0, coord.s / 64, coord.t / 64, 1.0);

    fColor = color;
}
