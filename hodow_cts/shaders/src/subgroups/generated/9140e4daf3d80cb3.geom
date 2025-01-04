#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID;
  dvec2 ref = dvec2(1);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref * data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(lessThan(abs(ref - subgroupExclusiveMul(data[gl_SubgroupInvocationID])), dvec2(gl_SubgroupSize==128 ? 0.000025: 0.00001))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = dvec2(1);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref * data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(lessThan(abs(ref - subgroupExclusiveMul(data[gl_SubgroupInvocationID])), dvec2(gl_SubgroupSize==128 ? 0.000025: 0.00001))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
