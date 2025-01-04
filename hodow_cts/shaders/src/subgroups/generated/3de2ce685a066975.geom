#version 450
#extension GL_KHR_shader_subgroup_shuffle_relative: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec4 op = subgroupShuffleDown(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID + id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
