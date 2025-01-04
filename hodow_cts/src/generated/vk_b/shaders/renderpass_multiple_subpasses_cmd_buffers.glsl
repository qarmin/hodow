#version 450
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 color;
layout(location = 0) out vec4 vtxColor;
void main (void)
{
	gl_Position = position;
	vtxColor = color;
}
#version 450
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor;
void main (void)
{
	fragColor = vtxColor;
}
