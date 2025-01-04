#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data[];
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
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
