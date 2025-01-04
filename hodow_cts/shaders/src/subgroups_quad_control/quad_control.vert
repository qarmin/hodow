#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 1) in vec2 inTexCoords;
layout(location = 0) out highp vec2 outTexCoords;
void main(void)
{
	gl_Position = inPosition;
	outTexCoords = inTexCoords;
}
