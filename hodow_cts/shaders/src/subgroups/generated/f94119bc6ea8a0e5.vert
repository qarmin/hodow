#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_KHR_shader_subgroup_basic: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  float data[128];
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
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float op = readInvocationARB(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float op = readInvocationARB(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
