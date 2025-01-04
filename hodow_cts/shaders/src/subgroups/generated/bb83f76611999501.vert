#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  const uint swapTable[4] = {3, 2, 1, 0};
  tempRes = 1;
  vector<float, 8> op = subgroupQuadSwapDiagonal(data[gl_SubgroupInvocationID]);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + swapTable[gl_SubgroupInvocationID & 0x3];
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
