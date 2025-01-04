#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
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
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
