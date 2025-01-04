#version 460
#extension GL_EXT_tessellation_shader : require

in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[];
layout(vertices = 3) out;
out gl_PerVertex
{
  vec4 gl_Position;
} gl_out[];

void main(void)
{
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_TessLevelInner[0] = 1;
  gl_TessLevelInner[1] = 1;
  gl_TessLevelOuter[gl_InvocationID] = 1;
}
