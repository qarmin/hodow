#version 450
layout(location = 0) out uint outColor;
layout(binding=0, r32ui) readonly uniform uimage2D image;
void main (void)
{
	uint c = imageLoad(image, ivec2(uint(gl_FragCoord.x), uint(gl_FragCoord.y))).x;
	outColor = uint(fwidth(c));
}
