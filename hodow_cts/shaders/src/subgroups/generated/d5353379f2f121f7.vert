#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupGeMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i >= gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i < gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
