#version 450
#extension GL_KHR_shader_subgroup_vote: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uint tempRes;
  f16vec2 valueEqual = f16vec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  f16vec2 valueNoEqual = f16vec2(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(f16vec2(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(f16vec2(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
