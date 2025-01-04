#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  f16vec4 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  const uint swapTable[4] = {1, 0, 3, 2};
  tempRes = 1;
  f16vec4 op = subgroupQuadSwapHorizontal(data[gl_SubgroupInvocationID]);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + swapTable[gl_SubgroupInvocationID & 0x3];
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  result = tempRes;
}
