#version 450
#extension GL_KHR_shader_subgroup_vote: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data[];
};

void main (void)
{
  uint tempRes;
  tempRes = subgroupAll(true) ? 0x1 : 0;
  tempRes |= subgroupAll(false) ? 0 : 0x1A;
  tempRes |= 0x4;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
