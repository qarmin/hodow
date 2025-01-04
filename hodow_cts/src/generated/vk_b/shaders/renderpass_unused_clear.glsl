#version 450
precision highp float;
layout(location = 0) in vec4 position;
layout(location = 0) out vec4 vtxColor;
void main (void)
{
	gl_Position = position;
	vtxColor = vec4(0.5, 0.5, 0.5, 1.0);
}
#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
void main (void)
{
}
#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor0;
void main (void)
{
	fragColor0 = vtxColor;
}
#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 1) out vec4 fragColor1;
void main (void)
{
	fragColor1 = vtxColor;
}
#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor0;
layout(location = 1) out vec4 fragColor1;
void main (void)
{
	fragColor0 = vtxColor;
	fragColor1 = vtxColor;
}
#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 2) out vec4 fragColor2;
void main (void)
{
	fragColor2 = vtxColor;
}
#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor0;
layout(location = 2) out vec4 fragColor2;
void main (void)
{
	fragColor0 = vtxColor;
	fragColor2 = vtxColor;
}
#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 1) out vec4 fragColor1;
layout(location = 2) out vec4 fragColor2;
void main (void)
{
	fragColor1 = vtxColor;
	fragColor2 = vtxColor;
}
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
#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 3) out vec4 fragColor3;
void main (void)
{
	fragColor3 = vtxColor;
}
#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor0;
layout(location = 3) out vec4 fragColor3;
void main (void)
{
	fragColor0 = vtxColor;
	fragColor3 = vtxColor;
}
#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 1) out vec4 fragColor1;
layout(location = 3) out vec4 fragColor3;
void main (void)
{
	fragColor1 = vtxColor;
	fragColor3 = vtxColor;
}
#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor0;
layout(location = 1) out vec4 fragColor1;
layout(location = 3) out vec4 fragColor3;
void main (void)
{
	fragColor0 = vtxColor;
	fragColor1 = vtxColor;
	fragColor3 = vtxColor;
}
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
#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor0;
layout(location = 2) out vec4 fragColor2;
layout(location = 3) out vec4 fragColor3;
void main (void)
{
	fragColor0 = vtxColor;
	fragColor2 = vtxColor;
	fragColor3 = vtxColor;
}
#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 1) out vec4 fragColor1;
layout(location = 2) out vec4 fragColor2;
layout(location = 3) out vec4 fragColor3;
void main (void)
{
	fragColor1 = vtxColor;
	fragColor2 = vtxColor;
	fragColor3 = vtxColor;
}
#version 450
precision highp float;
layout(location = 0) in vec4 vtxColor;
layout(location = 0) out vec4 fragColor0;
layout(location = 1) out vec4 fragColor1;
layout(location = 2) out vec4 fragColor2;
layout(location = 3) out vec4 fragColor3;
void main (void)
{
	fragColor0 = vtxColor;
	fragColor1 = vtxColor;
	fragColor2 = vtxColor;
	fragColor3 = vtxColor;
}
