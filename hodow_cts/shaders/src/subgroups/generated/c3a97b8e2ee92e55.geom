#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i < gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
