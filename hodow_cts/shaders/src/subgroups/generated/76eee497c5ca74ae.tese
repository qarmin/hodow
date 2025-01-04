#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_KHR_shader_subgroup_basic: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data[];
};

bool subgroupBallotBitExtract(uint64_t value, uint index)
{
    if (index > 63)
        return false;
    uint64_t mask = 1ul << index;
    if (bool((value & mask)) == true)
        return true;
    return false;
}
void main (void)
{
  uint tempRes;
  uint64_t mask;
mask = ballotARB(true);
  uint sgSize = gl_SubGroupSizeARB;
  uint sgInvocation = gl_SubGroupInvocationARB;
  tempRes = 0;
  uint firstActive = 0;
  for (uint i = 0; i < sgSize; i++)
  {
    if (subgroupBallotBitExtract(mask, i))
    {
      firstActive = i;
      break;
    }
  }
  tempRes |= (readFirstInvocationARB(data[sgInvocation]) == data[firstActive]) ? 0x1 : 0;
  // make the firstActive invocation inactive now
  if (firstActive != sgInvocation)
  {
mask = ballotARB(true);
    for (uint i = 0; i < sgSize; i++)
    {
      if (subgroupBallotBitExtract(mask, i))
      {
        firstActive = i;
        break;
      }
    }
    tempRes |= (readFirstInvocationARB(data[sgInvocation]) == data[firstActive]) ? 0x2 : 0;
  }
  else
  {
    // the firstActive invocation didn't partake in the second result so set it to true
    tempRes |= 0x2;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
