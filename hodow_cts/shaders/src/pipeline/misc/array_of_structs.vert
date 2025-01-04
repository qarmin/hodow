#version 450
struct R { vec4 rgba; };
layout(location = 0) out R outColor[3];
void main (void)
{
  outColor[0].rgba = vec4(0.0, 0.9, 0.0, 1.0);
  outColor[1].rgba = vec4(0.3, 0.0, 0.0, 1.0);
  outColor[2].rgba = vec4(0.0, 0.0, 0.6, 1.0);
  const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
  const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
  gl_Position = vec4(x, y, 0.6, 1.0);
}
