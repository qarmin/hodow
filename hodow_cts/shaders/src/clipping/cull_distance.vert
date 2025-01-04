#version 450
layout(location = 0) in vec4 v_position;
out gl_PerVertex {
  vec4  gl_Position;
  float gl_CullDistance[3];
};
void main (void)
{
  gl_Position = v_position;
  gl_CullDistance[0] = 0.0 - float(gl_VertexIndex == 2);
  gl_CullDistance[1] = 0.0 - float(gl_VertexIndex == 1);
  gl_CullDistance[2] = 0.0 - float(gl_VertexIndex == 0);
}
