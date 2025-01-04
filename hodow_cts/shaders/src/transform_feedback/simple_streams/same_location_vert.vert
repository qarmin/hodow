#version 450

layout(location=0) out uint id;void main(void)
{
  id = gl_VertexIndex;}
