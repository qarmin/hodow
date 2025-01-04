#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  {
  i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], 0);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + 0;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  {
  i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], 1);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + 1;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  {
  i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], 2);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + 2;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  {
  i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], 3);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + 3;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
