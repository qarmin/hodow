#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 2) out vec4 fragColor2;
void main (void)
{
	fragColor2 = vtxColor;
}
