#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  int8_t data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    int8_t data1_val = data1[gl_SubgroupInvocationID];
    int8_t op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  int8_t data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    int8_t data1_val = data1[gl_SubgroupInvocationID];
    int8_t op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i8vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    i8vec2 data1_val = data1[gl_SubgroupInvocationID];
    i8vec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i8vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    i8vec2 data1_val = data1[gl_SubgroupInvocationID];
    i8vec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i8vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    i8vec3 data1_val = data1[gl_SubgroupInvocationID];
    i8vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i8vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    i8vec3 data1_val = data1[gl_SubgroupInvocationID];
    i8vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i8vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    i8vec4 data1_val = data1[gl_SubgroupInvocationID];
    i8vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i8vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    i8vec4 data1_val = data1[gl_SubgroupInvocationID];
    i8vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<int8_t, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vector<int8_t, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<int8_t, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<int8_t, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vector<int8_t, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<int8_t, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uint8_t data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    uint8_t data1_val = data1[gl_SubgroupInvocationID];
    uint8_t op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uint8_t data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    uint8_t data1_val = data1[gl_SubgroupInvocationID];
    uint8_t op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u8vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    u8vec3 data1_val = data1[gl_SubgroupInvocationID];
    u8vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u8vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    u8vec3 data1_val = data1[gl_SubgroupInvocationID];
    u8vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u8vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    u8vec4 data1_val = data1[gl_SubgroupInvocationID];
    u8vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u8vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    u8vec4 data1_val = data1[gl_SubgroupInvocationID];
    u8vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<uint8_t, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vector<uint8_t, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<uint8_t, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<uint8_t, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vector<uint8_t, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<uint8_t, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  int16_t data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    int16_t data1_val = data1[gl_SubgroupInvocationID];
    int16_t op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  int16_t data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    int16_t data1_val = data1[gl_SubgroupInvocationID];
    int16_t op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i16vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    i16vec2 data1_val = data1[gl_SubgroupInvocationID];
    i16vec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i16vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    i16vec2 data1_val = data1[gl_SubgroupInvocationID];
    i16vec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i16vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    i16vec3 data1_val = data1[gl_SubgroupInvocationID];
    i16vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i16vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    i16vec3 data1_val = data1[gl_SubgroupInvocationID];
    i16vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i16vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    i16vec4 data1_val = data1[gl_SubgroupInvocationID];
    i16vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i16vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    i16vec4 data1_val = data1[gl_SubgroupInvocationID];
    i16vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<int16_t, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vector<int16_t, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<int16_t, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<int16_t, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vector<int16_t, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<int16_t, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uint16_t data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uint16_t data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u16vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    u16vec2 data1_val = data1[gl_SubgroupInvocationID];
    u16vec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u16vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    u16vec2 data1_val = data1[gl_SubgroupInvocationID];
    u16vec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u16vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    u16vec3 data1_val = data1[gl_SubgroupInvocationID];
    u16vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u16vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    u16vec3 data1_val = data1[gl_SubgroupInvocationID];
    u16vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u16vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    u16vec4 data1_val = data1[gl_SubgroupInvocationID];
    u16vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u16vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    u16vec4 data1_val = data1[gl_SubgroupInvocationID];
    u16vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vector<uint16_t, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<uint16_t, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vector<uint16_t, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<uint16_t, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  int data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    int data1_val = data1[gl_SubgroupInvocationID];
    int op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  int data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    int data1_val = data1[gl_SubgroupInvocationID];
    int op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  ivec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    ivec2 data1_val = data1[gl_SubgroupInvocationID];
    ivec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  ivec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    ivec2 data1_val = data1[gl_SubgroupInvocationID];
    ivec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  ivec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    ivec3 data1_val = data1[gl_SubgroupInvocationID];
    ivec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  ivec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    ivec3 data1_val = data1[gl_SubgroupInvocationID];
    ivec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  ivec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    ivec4 data1_val = data1[gl_SubgroupInvocationID];
    ivec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  ivec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    ivec4 data1_val = data1[gl_SubgroupInvocationID];
    ivec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<int, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vector<int, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<int, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<int, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vector<int, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<int, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uint data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    uint data1_val = data1[gl_SubgroupInvocationID];
    uint op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uint data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    uint data1_val = data1[gl_SubgroupInvocationID];
    uint op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uvec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    uvec2 data1_val = data1[gl_SubgroupInvocationID];
    uvec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uvec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    uvec2 data1_val = data1[gl_SubgroupInvocationID];
    uvec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uvec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    uvec3 data1_val = data1[gl_SubgroupInvocationID];
    uvec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uvec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    uvec3 data1_val = data1[gl_SubgroupInvocationID];
    uvec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uvec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    uvec4 data1_val = data1[gl_SubgroupInvocationID];
    uvec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uvec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    uvec4 data1_val = data1[gl_SubgroupInvocationID];
    uvec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<uint, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vector<uint, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<uint, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<uint, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vector<uint, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<uint, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  int64_t data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    int64_t data1_val = data1[gl_SubgroupInvocationID];
    int64_t op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  int64_t data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    int64_t data1_val = data1[gl_SubgroupInvocationID];
    int64_t op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i64vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    i64vec2 data1_val = data1[gl_SubgroupInvocationID];
    i64vec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i64vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    i64vec2 data1_val = data1[gl_SubgroupInvocationID];
    i64vec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i64vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    i64vec3 data1_val = data1[gl_SubgroupInvocationID];
    i64vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i64vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    i64vec3 data1_val = data1[gl_SubgroupInvocationID];
    i64vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i64vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    i64vec4 data1_val = data1[gl_SubgroupInvocationID];
    i64vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i64vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    i64vec4 data1_val = data1[gl_SubgroupInvocationID];
    i64vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<int64_t, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vector<int64_t, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<int64_t, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<int64_t, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vector<int64_t, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<int64_t, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uint64_t data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    uint64_t data1_val = data1[gl_SubgroupInvocationID];
    uint64_t op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uint64_t data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    uint64_t data1_val = data1[gl_SubgroupInvocationID];
    uint64_t op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u64vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    u64vec2 data1_val = data1[gl_SubgroupInvocationID];
    u64vec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u64vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    u64vec2 data1_val = data1[gl_SubgroupInvocationID];
    u64vec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u64vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    u64vec3 data1_val = data1[gl_SubgroupInvocationID];
    u64vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u64vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    u64vec3 data1_val = data1[gl_SubgroupInvocationID];
    u64vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u64vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    u64vec4 data1_val = data1[gl_SubgroupInvocationID];
    u64vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u64vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    u64vec4 data1_val = data1[gl_SubgroupInvocationID];
    u64vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<uint64_t, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vector<uint64_t, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<uint64_t, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<uint64_t, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vector<uint64_t, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<uint64_t, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  float16_t data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    float16_t data1_val = data1[gl_SubgroupInvocationID];
    float16_t op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  float16_t data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    float16_t data1_val = data1[gl_SubgroupInvocationID];
    float16_t op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  f16vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    f16vec2 data1_val = data1[gl_SubgroupInvocationID];
    f16vec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  f16vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    f16vec2 data1_val = data1[gl_SubgroupInvocationID];
    f16vec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  f16vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    f16vec3 data1_val = data1[gl_SubgroupInvocationID];
    f16vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  f16vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    f16vec3 data1_val = data1[gl_SubgroupInvocationID];
    f16vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  f16vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    f16vec4 data1_val = data1[gl_SubgroupInvocationID];
    f16vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  f16vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    f16vec4 data1_val = data1[gl_SubgroupInvocationID];
    f16vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<float16_t, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vector<float16_t, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<float16_t, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<float16_t, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vector<float16_t, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<float16_t, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  float data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    float data1_val = data1[gl_SubgroupInvocationID];
    float op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  float data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    float data1_val = data1[gl_SubgroupInvocationID];
    float op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vec2 data1_val = data1[gl_SubgroupInvocationID];
    vec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vec2 data1_val = data1[gl_SubgroupInvocationID];
    vec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vec3 data1_val = data1[gl_SubgroupInvocationID];
    vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vec3 data1_val = data1[gl_SubgroupInvocationID];
    vec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vec4 data1_val = data1[gl_SubgroupInvocationID];
    vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vec4 data1_val = data1[gl_SubgroupInvocationID];
    vec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<float, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vector<float, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<float, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<float, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vector<float, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<float, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  double data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    double data1_val = data1[gl_SubgroupInvocationID];
    double op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  double data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    double data1_val = data1[gl_SubgroupInvocationID];
    double op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  dvec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    dvec2 data1_val = data1[gl_SubgroupInvocationID];
    dvec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  dvec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    dvec2 data1_val = data1[gl_SubgroupInvocationID];
    dvec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  dvec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    dvec3 data1_val = data1[gl_SubgroupInvocationID];
    dvec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  dvec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    dvec3 data1_val = data1[gl_SubgroupInvocationID];
    dvec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  dvec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    dvec4 data1_val = data1[gl_SubgroupInvocationID];
    dvec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  dvec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    dvec4 data1_val = data1[gl_SubgroupInvocationID];
    dvec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<double, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vector<double, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<double, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<double, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vector<double, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<double, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  bool data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    bool data1_val = data1[gl_SubgroupInvocationID];
    bool op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  bool data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    bool data1_val = data1[gl_SubgroupInvocationID];
    bool op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  bvec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    bvec2 data1_val = data1[gl_SubgroupInvocationID];
    bvec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  bvec2 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    bvec2 data1_val = data1[gl_SubgroupInvocationID];
    bvec2 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  bvec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    bvec3 data1_val = data1[gl_SubgroupInvocationID];
    bvec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  bvec3 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    bvec3 data1_val = data1[gl_SubgroupInvocationID];
    bvec3 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  bvec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    bvec4 data1_val = data1[gl_SubgroupInvocationID];
    bvec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  bvec4 data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    bvec4 data1_val = data1[gl_SubgroupInvocationID];
    bvec4 op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<bool, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
    uint cluster_res;
    vector<bool, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<bool, 8> op;
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
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<bool, 8> data1[];
};
layout(set = 0, binding = 2, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res = 1;
  uvec4 mask = subgroupBallot(true);
  uint cluster_size;
  for (cluster_size = 1; cluster_size <= gl_SubgroupSize; cluster_size *= 2)
  {
    uint id_in = 5;
    uint cluster_res;
    vector<bool, 8> data1_val = data1[gl_SubgroupInvocationID];
    vector<bool, 8> op;
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
  result[offset] = tempRes;
}
