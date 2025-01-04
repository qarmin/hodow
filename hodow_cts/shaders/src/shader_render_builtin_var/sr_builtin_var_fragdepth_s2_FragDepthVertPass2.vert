#version 450

layout (location = 0) in vec4 position;
layout (location = 1) out vec2 texCoord;
void main()
{
    gl_Position = position;
    gl_PointSize = 1.0;
    texCoord = position.xy/2 + vec2(0.5);
}
