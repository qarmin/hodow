#version 450
#extension GL_KHR_shader_subgroup_vote: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  vector<uint16_t, 8> valueEqual = vector<uint16_t, 8>(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vector<uint16_t, 8> valueNoEqual = vector<uint16_t, 8>(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vector<uint16_t, 8>(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vector<uint16_t, 8>(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
