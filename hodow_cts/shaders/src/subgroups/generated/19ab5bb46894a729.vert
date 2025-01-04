#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  uint tempRes;
  bool valueEqual = bool(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  bool valueNoEqual = bool(subgroupElect());
  tempRes = allInvocationsEqualARB(bool(1)) ? 0x1 : 0;
  tempRes |= 0x2;
  tempRes |= allInvocationsEqualARB(data[0]) ? 0x4 : 0;
  tempRes |= allInvocationsEqualARB(valueEqual) ? 0x8 : 0x0;
  tempRes |= allInvocationsEqualARB(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
