#version 310 es
layout (location = 0) in highp vec4 a_position;
void main()
{
    gl_Position = vec4(a_position.xy, 1.0, 1.0);
}
