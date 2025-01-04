#version 460
layout (location=0) in vec2 inPos;
out gl_PerVertex {
  vec4 gl_Position;
  float gl_CullDistance[1];
};
void main (void)
{
    gl_CullDistance[0] = 0.5 - float((gl_VertexIndex < 5));
    gl_Position = vec4(inPos, 1.0, 1.0);
}
