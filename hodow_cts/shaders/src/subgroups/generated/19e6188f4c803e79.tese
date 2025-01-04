#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  {
  dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], 0);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + 0;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  {
  dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], 1);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + 1;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  {
  dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], 2);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + 2;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  {
  dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], 3);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + 3;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
