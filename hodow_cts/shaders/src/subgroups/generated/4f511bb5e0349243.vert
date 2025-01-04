#version 450
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) out vec4 out_color;
layout(location = 0) in highp vec4 in_position;

void main (void)
{
  out_color = vec4(gl_SubgroupSize, gl_SubgroupInvocationID + 1024, 1.0f, 1.0f);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
