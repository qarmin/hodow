#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uint64_t value = gl_SubGroupEqMaskARB;
  bool temp = true;
  uint64_t mask = uint64_t(1) << gl_SubGroupInvocationARB;
  temp = (value & mask) != 0;
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
