#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 2) out vec4 fragColor2;
layout(location = 3) out vec4 fragColor3;
void main (void)
{
	fragColor2 = vtxColor;
	fragColor3 = vtxColor;
}
