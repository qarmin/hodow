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
  uint data[];
};

void main (void)
{
  uint tempRes;
  tempRes = allInvocationsARB(true) ? 0x1 : 0;
  tempRes |= allInvocationsARB(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
