#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
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
  tempResult |= !bool(uvec4(0) == subgroupBallot(true)) ? 0x1 : 0;
  bool bData = data[gl_SubgroupInvocationID] != 0;
  tempResult |= !bool(uvec4(0) == subgroupBallot(bData)) ? 0x2 : 0;
  tempResult |= uvec4(0) == subgroupBallot(false) ? 0x4 : 0;
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
