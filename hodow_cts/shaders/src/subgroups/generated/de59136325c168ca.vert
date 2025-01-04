#version 450
#extension GL_KHR_shader_subgroup_vote: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec4 data[128];
};

void main (void)
{
  uint tempRes;
  u64vec4 valueEqual = u64vec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  u64vec4 valueNoEqual = u64vec4(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(u64vec4(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(u64vec4(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
