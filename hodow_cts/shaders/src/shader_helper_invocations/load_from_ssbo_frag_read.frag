#version 450
layout(location = 0) out uint outColor;
layout(std430, binding=0) readonly buffer Input { uint v[]; };
void main (void)
{
	uint i = uint(gl_FragCoord.y)*32+uint(gl_FragCoord.x);
	outColor = uint(fwidth(v[i]));
}
