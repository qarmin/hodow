#version 450
layout(location = 0) out uvec4 o_color0;
layout(location = 1) out uvec4 o_color1;
layout(location = 2) out uvec4 o_color2;
layout(location = 3) out uvec4 o_color3;
void main (void)
{
	o_color0 = uvec4(0, 64, 192, 252);
	o_color1 = uvec4(0, 64, 192, 252);
	o_color2 = uvec4(0, 64, 192, 252);
	o_color3 = uvec4(0, 64, 192, 252);
}
