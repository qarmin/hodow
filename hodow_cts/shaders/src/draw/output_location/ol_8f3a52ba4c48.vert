#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in float color_in;
layout(location = 0) smooth out float color_out;

void main()
{
	gl_Position = vec4(position_in, 0, 1);
    color_out = color_in;
}
