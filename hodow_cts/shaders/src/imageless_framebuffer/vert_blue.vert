#version 440

layout(location = 0) in highp vec4 a_position;
layout(location = 0) out highp vec4 a_color;

void main (void)
{
    gl_Position = a_position;
    a_color = vec4(0.0f, 0.0f, 1.0f, 1.0f);
}
