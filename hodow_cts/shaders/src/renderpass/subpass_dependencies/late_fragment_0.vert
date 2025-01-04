#version 450
highp float;
layout(location = 0) in highp vec4 position;
void main (void)
{
    gl_Position = position;
}
