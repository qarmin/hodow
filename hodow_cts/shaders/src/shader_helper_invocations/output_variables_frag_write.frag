#version 450
layout(location = 0) out uint outColor;
void main (void)
{
	outColor = 84;
	outColor = uint(gl_FragCoord.y)*32+uint(gl_FragCoord.x);
}
