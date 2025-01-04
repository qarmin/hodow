#version 450
#extension GL_KHR_shader_subgroup_vote: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data[];
};

void main (void)
{
  uint tempRes;
  uint16_t valueEqual = uint16_t(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  uint16_t valueNoEqual = uint16_t(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(uint16_t(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(uint16_t(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
