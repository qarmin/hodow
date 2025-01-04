#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
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
  tempResult |= !bool(uvec4(0) == subgroupBallot(true)) ? 0x1 : 0;
  bool bData = data[gl_SubgroupInvocationID] != 0;
  tempResult |= !bool(uvec4(0) == subgroupBallot(bData)) ? 0x2 : 0;
  tempResult |= uvec4(0) == subgroupBallot(false) ? 0x4 : 0;
  tempRes = tempResult;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
