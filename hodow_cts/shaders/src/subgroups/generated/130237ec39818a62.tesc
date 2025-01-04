#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  {
  uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], 0);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + 0;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  {
  uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], 1);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + 1;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  {
  uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], 2);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + 2;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  {
  uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], 3);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + 3;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
