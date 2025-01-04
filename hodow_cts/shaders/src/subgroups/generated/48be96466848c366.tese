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
  dvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
