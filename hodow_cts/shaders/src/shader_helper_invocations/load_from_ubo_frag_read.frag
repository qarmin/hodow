#version 450
layout(location = 0) out uint outColor;
layout(binding=0) uniform Input { uvec4 v[32*8]; };
void main (void)
{
	uint i = uint(gl_FragCoord.y)*8+uint(gl_FragCoord.x) / 4;
	uvec4 color = v[i];
	outColor = uint(fwidth(color[uint(gl_FragCoord.x) % 4]));
}
