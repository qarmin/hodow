#version 450

layout(location = 0) in vec4 position;

void main (void)
{
    gl_Position = position;
}
#version 450

layout(location = 0) out vec4 fragColor;

void main (void)
{
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
