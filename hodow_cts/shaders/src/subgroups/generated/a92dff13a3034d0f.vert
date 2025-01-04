#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i <= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
