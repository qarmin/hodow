#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint64_t value = gl_SubGroupGtMaskARB;
  bool temp = true;
  for (uint i = 0; i < gl_SubGroupSizeARB; i++) {
    uint64_t mask = uint64_t(1) << i;
    if (i > gl_SubGroupInvocationARB && (value & mask) == 0)
       temp = false;
    if (i <= gl_SubGroupInvocationARB && (value & mask) != 0)
       temp = false;
  };
  uint tempResult = temp ? 0xf : 0x2;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
