#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) out uint out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
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
  tempRes |= anyInvocationARB(gl_HelperInvocation) ? 0x1 : 0x0;
  tempRes |= anyInvocationARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  out_color = tempRes;
}
