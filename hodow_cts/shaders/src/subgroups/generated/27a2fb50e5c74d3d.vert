#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupSize;
  vector<bool, 8> ref = vector<bool, 8>(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = vector<bool, 8>(ref[0] || data[index][0], ref[1] || data[index][1], ref[2] || data[index][2], ref[3] || data[index][3], ref[4] || data[index][4], ref[5] || data[index][5], ref[6] || data[index][6], ref[7] || data[index][7]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupOr(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<bool, 8>(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = vector<bool, 8>(ref[0] || data[index][0], ref[1] || data[index][1], ref[2] || data[index][2], ref[3] || data[index][3], ref[4] || data[index][4], ref[5] || data[index][5], ref[6] || data[index][6], ref[7] || data[index][7]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupOr(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
