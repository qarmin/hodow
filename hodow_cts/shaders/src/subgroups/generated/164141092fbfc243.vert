#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupSize;
  dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupMin(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = dvec2(intBitsToFloat(0x7f800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupMin(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
