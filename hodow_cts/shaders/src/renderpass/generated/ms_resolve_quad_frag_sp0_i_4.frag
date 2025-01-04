#version 450
layout(location = 0) out ivec4 o_color0;
layout(location = 1) out ivec4 o_color1;
layout(location = 2) out ivec4 o_color2;
layout(location = 3) out ivec4 o_color3;
void main (void)
{
	o_color0 = ivec4(0, 32, 100, 124);
	o_color1 = ivec4(0, 32, 100, 124);
	o_color2 = ivec4(0, 32, 100, 124);
	o_color3 = ivec4(0, 32, 100, 124);
}
