#version 450
#extension GL_KHR_shader_subgroup_vote: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  uint data[];
};
void main (void)
{
  uint tempRes;
  tempRes = subgroupAll(true) ? 0x1 : 0;
  tempRes |= subgroupAll(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  result = tempRes;
}
