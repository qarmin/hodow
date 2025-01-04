#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uvec4 allOnes = uvec4(0xFFFFFFFF);
  uvec4 allZeros = uvec4(0);
  uint tempResult = 0;
#define MAKE_HIGH_BALLOT_RESULT(i) uvec4(i >= 32 ? 0 : (0xFFFFFFFF << i), i >= 64 ? 0 : (0xFFFFFFFF << ((i < 32) ? 0 : (i - 32))), i >= 96 ? 0 : (0xFFFFFFFF << ((i < 64) ? 0 : (i - 64))), i >= 128 ? 0 : (0xFFFFFFFF << ((i < 96) ? 0 : (i - 96))))
#define MAKE_SINGLE_BIT_BALLOT_RESULT(i) uvec4(i >= 32 ? 0 : 0x1 << i, i < 32 || i >= 64 ? 0 : 0x1 << (i - 32), i < 64 || i >= 96 ? 0 : 0x1 << (i - 64), i < 96 || i >= 128 ? 0 : 0x1 << (i - 96))
  tempResult |= subgroupInverseBallot(allOnes) ? 0x1 : 0;
  tempResult |= subgroupInverseBallot(allZeros) ? 0 : 0x2;
  tempResult |= subgroupInverseBallot(subgroupBallot(true)) ? 0x4 : 0;
  tempResult |= 0x8;
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
