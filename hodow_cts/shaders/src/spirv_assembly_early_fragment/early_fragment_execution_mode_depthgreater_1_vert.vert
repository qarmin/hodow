#version 430
layout(location = 0) in vec4 position;

void main()
{
    gl_Position = vec4(position.xy, 0.7, 1.0);
}
