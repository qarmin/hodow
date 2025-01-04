#version 450
#extension GL_KHR_shader_subgroup_vote: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data[];
};

void main (void)
{
  uint tempRes;
  vec2 valueEqual = vec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vec2 valueNoEqual = vec2(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vec2(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vec2(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
