#version 450
#extension GL_KHR_shader_subgroup_vote: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec3 data[128];
};

void main (void)
{
  uint tempRes;
  vec3 valueEqual = vec3(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vec3 valueNoEqual = vec3(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vec3(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vec3(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
