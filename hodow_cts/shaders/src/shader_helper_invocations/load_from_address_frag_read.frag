#version 450
#extension GL_EXT_buffer_reference : require
layout(location = 0) out uint outColor;
layout(std430, buffer_reference, buffer_reference_align = 4) readonly buffer Data
{ uint v[]; };
layout(std430, push_constant) uniform Input { Data data; };
void main (void)
{
	uint i = uint(gl_FragCoord.y)*32+uint(gl_FragCoord.x);
	outColor = uint(fwidth(data.v[i]));
}
