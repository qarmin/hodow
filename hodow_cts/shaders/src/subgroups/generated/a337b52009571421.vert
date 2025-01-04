#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
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
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
