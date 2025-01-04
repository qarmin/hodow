#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    u8vec2 data1_val = data1[gl_SubgroupInvocationID];
    u8vec2 op;
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
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
