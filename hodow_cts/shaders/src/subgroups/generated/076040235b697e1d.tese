#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0;
  tempResult |= !bool(uint64_t(0) == ballotARB(true)) ? 0x1 : 0;
  bool bData = data[gl_SubgroupInvocationID] != 0;
  tempResult |= !bool(uint64_t(0) == ballotARB(bData)) ? 0x2 : 0;
  tempResult |= uint64_t(0) == ballotARB(false) ? 0x4 : 0;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
