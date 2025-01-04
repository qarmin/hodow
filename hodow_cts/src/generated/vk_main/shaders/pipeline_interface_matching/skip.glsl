#version 450
layout(location = 0) out vec4 v0;
layout(location = 1) out vec4 v1;
layout(location = 2) out vec4 v2;
void main (void)
{
  v0 = vec4(0.0, 1.0, 0.0, 0.0);
  v1 = vec4(1.0, 0.0, 0.0, 1.0);
  v2 = vec4(0.0, 0.0, 1.0, 1.0);
  const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
  const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
  gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(location = 0) in vec4 v0;
layout(location = 2) in vec4 v2;
layout(location = 0) out vec4 fragColor;
void main (void)
{
  fragColor = v0 + v2;
}
