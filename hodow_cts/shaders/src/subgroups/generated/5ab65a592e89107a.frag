#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) out uint out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};
void main()
{
  uint tempRes = 0u;
  if (dFdx(gl_SubgroupInvocationID * gl_FragCoord.x * gl_FragCoord.y) - dFdy(gl_SubgroupInvocationID * gl_FragCoord.x * gl_FragCoord.y) > 0.0f)
  {
    tempRes |= 0x20;
  }
  bool helper = anyInvocationARB(gl_HelperInvocation);
  if (helper)
  {
    tempRes |= 0x40;
  }
  bool valueEqual = bool(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  bool valueNoEqual = bool(subgroupElect());
  tempRes |= allInvocationsEqualARB(bool(1)) ? 0x10 : 0;
  tempRes |= 0x2;
  tempRes |= allInvocationsEqualARB(data[0]) ? 0x4 : 0;
  tempRes |= allInvocationsEqualARB(valueEqual) ? 0x8 : 0x0;
  tempRes |= allInvocationsEqualARB(gl_HelperInvocation) ? 0x0 : 0x1;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  out_color = tempRes;
}
