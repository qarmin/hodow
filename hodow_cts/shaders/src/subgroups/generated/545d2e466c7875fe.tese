#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupEqMaskARB;
  bool temp = true;
  uint64_t mask = uint64_t(1) << gl_SubGroupInvocationARB;
  temp = (value & mask) != 0;
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
