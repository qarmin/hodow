#version 450
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
void main (void)
{
  gl_Position = position;
  vtxColor = color + 0.1;
}
