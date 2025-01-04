#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  double data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID;
  double ref = double(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref + data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (abs(ref - subgroupExclusiveAdd(data[gl_SubgroupInvocationID])) < (gl_SubgroupSize==128 ? 0.000025:0.00001)) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = double(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref + data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (abs(ref - subgroupExclusiveAdd(data[gl_SubgroupInvocationID])) < (gl_SubgroupSize==128 ? 0.000025:0.00001)) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
