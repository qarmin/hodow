#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};

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
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
