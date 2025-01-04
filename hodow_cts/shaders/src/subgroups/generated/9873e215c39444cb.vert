#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_KHR_shader_subgroup_basic: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
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
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
