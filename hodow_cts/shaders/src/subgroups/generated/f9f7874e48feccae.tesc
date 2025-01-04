#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 allOnes = uvec4(0xFFFFFFFF);
  uvec4 allZeros = uvec4(0);
  uint tempResult = 0;
#define MAKE_HIGH_BALLOT_RESULT(i) uvec4(i >= 32 ? 0 : (0xFFFFFFFF << i), i >= 64 ? 0 : (0xFFFFFFFF << ((i < 32) ? 0 : (i - 32))), i >= 96 ? 0 : (0xFFFFFFFF << ((i < 64) ? 0 : (i - 64))), i >= 128 ? 0 : (0xFFFFFFFF << ((i < 96) ? 0 : (i - 96))))
#define MAKE_SINGLE_BIT_BALLOT_RESULT(i) uvec4(i >= 32 ? 0 : 0x1 << i, i < 32 || i >= 64 ? 0 : 0x1 << (i - 32), i < 64 || i >= 96 ? 0 : 0x1 << (i - 64), i < 96 || i >= 128 ? 0 : 0x1 << (i - 96))
  tempResult |= 0 == subgroupBallotFindLSB(allOnes) ? 0x1 : 0;
  if (subgroupElect())
  {
    tempResult |= 0x2;
  }
  else
  {
    tempResult |= 0 < subgroupBallotFindLSB(subgroupBallot(true)) ? 0x2 : 0;
  }
  tempResult |= gl_SubgroupSize > subgroupBallotFindLSB(subgroupBallot(true)) ? 0x4 : 0;
  tempResult |= 0x8;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if (i != subgroupBallotFindLSB(MAKE_HIGH_BALLOT_RESULT(i)))
    {
      tempResult &= ~0x8;
    }
  }
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
