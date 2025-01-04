#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor0;
void main (void)
{
	fragColor0 = vtxColor;
}
