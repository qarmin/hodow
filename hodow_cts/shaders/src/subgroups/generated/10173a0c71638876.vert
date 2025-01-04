#version 450
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;

void main (void)
{
  uint tempRes;
  tempRes = gl_SubgroupSize;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
