#version 450
#extension GL_KHR_shader_subgroup_vote: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 valueEqual = uvec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  uvec4 valueNoEqual = uvec4(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(uvec4(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(uvec4(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
