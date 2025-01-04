#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
