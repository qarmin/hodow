#version 450
#extension GL_KHR_shader_subgroup_basic: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = gl_SubgroupSize;
  tempRes = tempResult;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
