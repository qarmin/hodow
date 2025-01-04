#version 450 core
out gl_PerVertex
{
  vec4 gl_Position;
};
void main()
{
  gl_Position = vec4(float(1.0 - 2.0 * int(gl_VertexIndex != 1)) * 0.4 + -0.5,
                     float(1.0 - 2.0 * int(gl_VertexIndex > 0))  * 0.4 + -0.5, 0.0, 1.0);
}
