#version 450
#extension GL_KHR_shader_subgroup_vote: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data[];
};

void main (void)
{
  uint tempRes;
  float valueEqual = float(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  float valueNoEqual = float(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(float(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(float(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
