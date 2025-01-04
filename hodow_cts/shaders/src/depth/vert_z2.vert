#version 430
layout(location = 0) in vec2 position_in;

void main()
{
    gl_Position = vec4(position_in, 2, 1);
}
