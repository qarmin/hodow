#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_color;
void main (void)
{
    gl_Position = a_position;
}
