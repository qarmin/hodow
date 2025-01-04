#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupSize;
  f16vec2 ref = f16vec2(0);
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
  tempRes = all(lessThan(abs(ref - subgroupAdd(data[gl_SubgroupInvocationID])), f16vec2(gl_SubgroupSize==128 ? 0.2: 0.1))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = f16vec2(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref + data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(lessThan(abs(ref - subgroupAdd(data[gl_SubgroupInvocationID])), f16vec2(gl_SubgroupSize==128 ? 0.2: 0.1))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
