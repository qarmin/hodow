#version 450
precision highp float;
layout(location = 0) in vec4 position;
layout(location = 0) out vec4 vtxColor;
void main (void)
{
	gl_Position = position;
	vtxColor = vec4(0.5, 0.5, 0.5, 1.0);
}
