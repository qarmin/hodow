#version 450
layout(location = 0) out uint outColor;
layout(input_attachment_index=0, binding=0) uniform usubpassInput image;
void main (void)
{
	uint c = subpassLoad(image).x;
	outColor = c + uint(gl_FragCoord.y) * uint(gl_FragCoord.x);
}
