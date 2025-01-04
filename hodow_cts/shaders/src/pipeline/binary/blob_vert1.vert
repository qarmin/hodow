#version 450
layout(location = 0) out highp vec4 vertColor;
out gl_PerVertex { vec4 gl_Position; };
void main (void)
{
  const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
  const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
  vertColor = vec4(x, y, 0.0, 1.0);
  gl_Position = vec4(x, y, 0.0, 1.0);
}
