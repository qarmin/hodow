#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec2 data[128];
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
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
