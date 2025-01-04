#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  uint cluster[4] =
  {
    subgroupQuadBroadcast(gl_SubgroupInvocationID, 0),
    subgroupQuadBroadcast(gl_SubgroupInvocationID, 1),
    subgroupQuadBroadcast(gl_SubgroupInvocationID, 2),
    subgroupQuadBroadcast(gl_SubgroupInvocationID, 3)
  };
  uint rootID = gl_SubgroupInvocationID & ~0x3;
  for (uint i = 0; i < 4; i++)
  {
    uint nextID = rootID + i;
    if (subgroupBallotBitExtract(mask, nextID) && (cluster[i] != nextID))
    {
      tempResult = mask.x;
    }
  }
  tempRes = tempResult;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
