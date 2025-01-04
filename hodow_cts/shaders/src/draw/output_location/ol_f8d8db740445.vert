#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in vec4 color_in;
layout(location = 0) smooth out vec4 color_out;

void main()
{
	gl_Position = vec4(position_in, 0, 1);
    color_out = color_in;
}
