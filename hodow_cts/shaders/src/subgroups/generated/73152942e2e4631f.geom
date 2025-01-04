#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint16_t data1[128];
};
layout(set = 0, binding = 1) uniform Buffer2
{
  uint data2[1];
};

void main (void)
{
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    uint16_t data1_val = data1[gl_SubgroupInvocationID];
    uint16_t op;
    switch (cluster_size)
    {
      case 1: op = subgroupClusteredRotate(data1_val, id_in, 1u); break;
      case 2: op = subgroupClusteredRotate(data1_val, id_in, 2u); break;
      case 4: op = subgroupClusteredRotate(data1_val, id_in, 4u); break;
      case 8: op = subgroupClusteredRotate(data1_val, id_in, 8u); break;
      case 16: op = subgroupClusteredRotate(data1_val, id_in, 16u); break;
      case 32: op = subgroupClusteredRotate(data1_val, id_in, 32u); break;
      case 64: op = subgroupClusteredRotate(data1_val, id_in, 64u); break;
      case 128: op = subgroupClusteredRotate(data1_val, id_in, 128u); break;
    }
    uint id = ((gl_SubgroupInvocationID + id_in) & (cluster_size - 1)) | (gl_SubgroupInvocationID & ~(cluster_size - 1));
    if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
    {
      cluster_res = (op == data1[id]) ? 1 : 0;
    }
    else
    {
      cluster_res = 1; // Invocation we read from was inactive, so we can't verify results!
    }
    temp_res = (temp_res & cluster_res);
  }
  tempRes = temp_res;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
