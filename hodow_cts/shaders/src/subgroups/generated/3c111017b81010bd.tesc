#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
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
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
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
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
