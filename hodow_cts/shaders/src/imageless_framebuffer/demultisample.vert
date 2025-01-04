#version 440

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
}
