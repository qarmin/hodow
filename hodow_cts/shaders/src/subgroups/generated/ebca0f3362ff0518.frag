#version 450
#extension GL_KHR_shader_subgroup_vote: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  u16vec4 data[];
};
void main (void)
{
  uint tempRes;
  u16vec4 valueEqual = u16vec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  u16vec4 valueNoEqual = u16vec4(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(u16vec4(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(u16vec4(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result = tempRes;
}
