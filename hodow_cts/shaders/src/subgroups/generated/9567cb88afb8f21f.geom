#version 450
#extension GL_ARB_shader_group_vote: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data[];
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
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
