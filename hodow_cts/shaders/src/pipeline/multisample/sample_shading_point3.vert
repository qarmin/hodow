#version 440
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 color;
void main (void)
{
    gl_Position = position;
    gl_PointSize = 3.0f;
}
