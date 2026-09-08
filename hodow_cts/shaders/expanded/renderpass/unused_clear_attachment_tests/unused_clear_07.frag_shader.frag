#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor0;
layout(location = 1) out vec4 fragColor1;
layout(location = 2) out vec4 fragColor2;
void main (void)
{
	fragColor0 = vtxColor;
	fragColor1 = vtxColor;
	fragColor2 = vtxColor;
}
