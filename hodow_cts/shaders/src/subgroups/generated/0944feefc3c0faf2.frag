#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  i16vec4 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID;
  i16vec4 ref = i16vec4(0x7fff);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = min(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupExclusiveMin(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec4(0x7fff);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = min(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupExclusiveMin(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = tempRes;
}
