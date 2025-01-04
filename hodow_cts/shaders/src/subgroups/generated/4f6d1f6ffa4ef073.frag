#version 450
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) out uint result;
void main (void)
{
  uint tempRes;
  uint tempResult = gl_SubgroupSize;
  tempRes = tempResult;
  result = tempRes;
}
