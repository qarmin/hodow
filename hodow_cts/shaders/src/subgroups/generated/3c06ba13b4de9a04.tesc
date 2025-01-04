#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<bool, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID;
  vector<bool, 8> ref = vector<bool, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupExclusiveAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<bool, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupExclusiveAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
