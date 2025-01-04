#version 450
void main (void)
{
  vec2 uv = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
  gl_Position = vec4(uv * 4.0f -2.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
