#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID;
  float ref = float(intBitsToFloat(0x7f800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupExclusiveMin(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = float(intBitsToFloat(0x7f800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupExclusiveMin(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
