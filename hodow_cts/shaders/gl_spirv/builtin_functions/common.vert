#version 450

layout (location = 0) in vec3 position;
layout (location = 1) out vec2 texCoord;

void main()
{
    texCoord = vec2(0.0, 0.0);
    gl_Position = vec4(position, 1.0);
}
