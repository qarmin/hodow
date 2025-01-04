#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float16_t, 8> data[128];
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
  vector<float16_t, 8> ref = vector<float16_t, 8>(1);
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
  tempRes = all(lessThan(abs(ref - subgroupExclusiveMul(data[gl_SubgroupInvocationID])), vector<float16_t, 8>(gl_SubgroupSize==128 ? 0.2: 0.1))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<float16_t, 8>(1);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref * data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(lessThan(abs(ref - subgroupExclusiveMul(data[gl_SubgroupInvocationID])), vector<float16_t, 8>(gl_SubgroupSize==128 ? 0.2: 0.1))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
