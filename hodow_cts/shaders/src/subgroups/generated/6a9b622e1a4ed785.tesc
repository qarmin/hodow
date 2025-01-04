#version 450
#extension GL_KHR_shader_subgroup_basic: enable
#extension GL_EXT_tessellation_shader : require
layout(vertices = 2) out;
void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
