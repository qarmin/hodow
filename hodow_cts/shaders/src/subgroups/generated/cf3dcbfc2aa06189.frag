#version 450
#extension GL_KHR_shader_subgroup_vote: enable
layout(location = 0) out uint out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int data[128];
};
void main()
{
  uint tempRes = 0u;
  if (dFdx(gl_SubgroupInvocationID * gl_FragCoord.x * gl_FragCoord.y) - dFdy(gl_SubgroupInvocationID * gl_FragCoord.x * gl_FragCoord.y) > 0.0f)
  {
    tempRes |= 0x20;
  }
  bool helper = subgroupAny(gl_HelperInvocation);
  if (helper)
  {
    tempRes |= 0x40;
  }
  int valueEqual = int(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  int valueNoEqual = int(gl_SubgroupInvocationID);
  tempRes |= subgroupAllEqual(int(1)) ? 0x10 : 0;
  tempRes |= subgroupAllEqual(int(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(gl_HelperInvocation) ? 0x0 : 0x1;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  out_color = tempRes;
}
