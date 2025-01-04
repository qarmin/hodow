#version 450
#extension GL_EXT_tessellation_shader : require
#extension GL_KHR_shader_subgroup_basic: enable
layout(vertices = 2) out;
layout(location = 0) out vec4 out_color[];
void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  out_color[gl_InvocationID] = vec4(gl_SubgroupSize, gl_SubgroupInvocationID + 1024, 0.0f, 0.0f);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
