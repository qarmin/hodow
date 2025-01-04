#version 450
#extension GL_KHR_shader_subgroup_vote: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec2 data[128];
};

void main (void)
{
  uint tempRes;
  u8vec2 valueEqual = u8vec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  u8vec2 valueNoEqual = u8vec2(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(u8vec2(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(u8vec2(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
