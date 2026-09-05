#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 3) out vec4 fragColor3;
void main (void)
{
	fragColor3 = vtxColor;
}
