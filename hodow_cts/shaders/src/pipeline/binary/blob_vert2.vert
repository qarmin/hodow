#version 450
layout(location = 0) out highp vec2 texCoord;
out gl_PerVertex { vec4 gl_Position; };
void main (void)
{
  texCoord = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
  gl_Position = vec4(texCoord * 2.0 - 1.0, 0.0, 1.0);
}
