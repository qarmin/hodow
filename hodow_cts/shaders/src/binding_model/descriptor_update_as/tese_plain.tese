#version 460
#extension GL_EXT_tessellation_shader : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[];

void main(void)
{
  gl_Position = gl_in[0].gl_Position;
}
