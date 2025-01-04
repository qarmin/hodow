#version 450
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
