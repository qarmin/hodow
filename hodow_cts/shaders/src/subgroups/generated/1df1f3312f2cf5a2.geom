#version 450
#extension GL_KHR_shader_subgroup_vote: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data[];
};

void main (void)
{
  uint tempRes;
  vector<int, 8> valueEqual = vector<int, 8>(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vector<int, 8> valueNoEqual = vector<int, 8>(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vector<int, 8>(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vector<int, 8>(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
