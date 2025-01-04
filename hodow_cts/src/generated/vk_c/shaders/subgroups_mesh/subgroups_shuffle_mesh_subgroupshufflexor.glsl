#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  int8_t data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int8_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int8_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;

void main (void)
{
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  int8_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  int8_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  int8_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  int8_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i8vec2 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i8vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i8vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i8vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i8vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i8vec3 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i8vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i8vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i8vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i8vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i8vec4 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i8vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i8vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i8vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i8vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<int8_t, 8> data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int8_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int8_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<int8_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<int8_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<int8_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<int8_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uint8_t data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint8_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint8_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  uint8_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  uint8_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  uint8_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  uint8_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u8vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u8vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u8vec3 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u8vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u8vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u8vec4 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u8vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u8vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<uint8_t, 8> data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint8_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint8_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<uint8_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<uint8_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<uint8_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<uint8_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  int16_t data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  int16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  int16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  int16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  int16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i16vec2 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i16vec3 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i16vec4 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<int16_t, 8> data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<int16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<int16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<int16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<int16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uint16_t data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  uint16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  uint16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  uint16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  uint16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u16vec2 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u16vec3 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u16vec4 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<uint16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<uint16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<uint16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<uint16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  int data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  int op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  int op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  int op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  int op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  ivec2 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  ivec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  ivec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  ivec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  ivec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  ivec3 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  ivec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  ivec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  ivec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  ivec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  ivec4 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  ivec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  ivec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  ivec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  ivec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<int, 8> data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<int, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<int, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<int, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<int, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uint data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  uint op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  uint op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  uint op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  uint op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uvec2 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  uvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  uvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  uvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  uvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uvec3 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  uvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  uvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  uvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  uvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uvec4 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  uvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  uvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  uvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  uvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<uint, 8> data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<uint, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<uint, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<uint, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<uint, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  int64_t data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int64_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int64_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  int64_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  int64_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  int64_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  int64_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i64vec2 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i64vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i64vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i64vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i64vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i64vec3 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i64vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i64vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i64vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i64vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  i64vec4 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i64vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  i64vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i64vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  i64vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<int64_t, 8> data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int64_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int64_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<int64_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<int64_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<int64_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<int64_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  uint64_t data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint64_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint64_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  uint64_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  uint64_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  uint64_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  uint64_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u64vec2 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u64vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u64vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u64vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u64vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u64vec3 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u64vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u64vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u64vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u64vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  u64vec4 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u64vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  u64vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u64vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u64vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<uint64_t, 8> data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint64_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint64_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<uint64_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<uint64_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<uint64_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<uint64_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  float16_t data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  float16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  float16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  float16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  float16_t op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  f16vec2 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  f16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  f16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  f16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  f16vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  f16vec3 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  f16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  f16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  f16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  f16vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  f16vec4 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  f16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  f16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  f16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  f16vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<float16_t, 8> data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<float16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<float16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<float16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<float16_t, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  float data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  float op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  float op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  float op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  float op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vec2 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vec3 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vec4 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<float, 8> data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<float, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<float, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<float, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<float, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  double data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  double op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  double op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  double op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  double op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  double op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  double op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  dvec2 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  dvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  dvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  dvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  dvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  dvec3 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  dvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  dvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  dvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  dvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  dvec4 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  dvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  dvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  dvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  dvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<double, 8> data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<double, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<double, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<double, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<double, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<double, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<double, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  bool data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bool op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bool op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  bool op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  bool op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  bool op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  bool op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  bvec2 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  bvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  bvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  bvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  bvec2 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  bvec3 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  bvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  bvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  bvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  bvec3 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  bvec4 data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  bvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  bvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  bvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  bvec4 op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) readonly buffer Buffer2
{
  vector<bool, 8> data1[];
};
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<bool, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 2, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<bool, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<bool, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] % 32;
  vector<bool, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<bool, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  vector<bool, 8> op = subgroupShuffleXor(data1[gl_SubgroupInvocationID], id_in);
  uint id = gl_SubgroupInvocationID ^ id_in;
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
