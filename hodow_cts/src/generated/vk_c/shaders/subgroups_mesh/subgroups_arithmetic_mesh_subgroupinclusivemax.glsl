#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int8_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  int8_t ref = int8_t(0x80);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int8_t(0x80);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int8_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  int8_t ref = int8_t(0x80);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int8_t(0x80);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
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
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i8vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i8vec2 ref = i8vec2(0x80);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec2(0x80);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i8vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i8vec2 ref = i8vec2(0x80);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec2(0x80);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i8vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i8vec3 ref = i8vec3(0x80);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec3(0x80);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i8vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i8vec3 ref = i8vec3(0x80);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec3(0x80);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i8vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i8vec4 ref = i8vec4(0x80);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec4(0x80);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i8vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i8vec4 ref = i8vec4(0x80);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec4(0x80);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int8_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<int8_t, 8> ref = vector<int8_t, 8>(0x80);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int8_t, 8>(0x80);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int8_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<int8_t, 8> ref = vector<int8_t, 8>(0x80);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int8_t, 8>(0x80);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint8_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  uint8_t ref = uint8_t(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint8_t(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint8_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  uint8_t ref = uint8_t(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint8_t(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u8vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u8vec2 ref = u8vec2(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec2(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u8vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u8vec2 ref = u8vec2(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec2(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u8vec3 ref = u8vec3(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec3(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u8vec3 ref = u8vec3(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec3(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u8vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u8vec4 ref = u8vec4(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec4(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u8vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u8vec4 ref = u8vec4(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec4(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint8_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<uint8_t, 8> ref = vector<uint8_t, 8>(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint8_t, 8>(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint8_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<uint8_t, 8> ref = vector<uint8_t, 8>(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint8_t, 8>(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int16_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  int16_t ref = int16_t(0x8000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int16_t(0x8000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int16_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  int16_t ref = int16_t(0x8000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int16_t(0x8000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i16vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i16vec2 ref = i16vec2(0x8000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec2(0x8000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i16vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i16vec2 ref = i16vec2(0x8000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec2(0x8000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i16vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i16vec3 ref = i16vec3(0x8000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec3(0x8000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i16vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i16vec3 ref = i16vec3(0x8000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec3(0x8000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i16vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i16vec4 ref = i16vec4(0x8000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec4(0x8000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i16vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i16vec4 ref = i16vec4(0x8000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec4(0x8000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int16_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<int16_t, 8> ref = vector<int16_t, 8>(0x8000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int16_t, 8>(0x8000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int16_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<int16_t, 8> ref = vector<int16_t, 8>(0x8000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int16_t, 8>(0x8000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint16_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  uint16_t ref = uint16_t(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint16_t(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint16_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  uint16_t ref = uint16_t(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint16_t(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u16vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u16vec2 ref = u16vec2(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec2(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u16vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u16vec2 ref = u16vec2(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec2(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u16vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u16vec3 ref = u16vec3(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec3(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u16vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u16vec3 ref = u16vec3(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec3(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u16vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u16vec4 ref = u16vec4(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec4(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u16vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u16vec4 ref = u16vec4(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec4(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint16_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<uint16_t, 8> ref = vector<uint16_t, 8>(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint16_t, 8>(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint16_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<uint16_t, 8> ref = vector<uint16_t, 8>(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint16_t, 8>(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  int ref = int(0x80000000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int(0x80000000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  int ref = int(0x80000000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int(0x80000000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  ivec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  ivec2 ref = ivec2(0x80000000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec2(0x80000000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  ivec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  ivec2 ref = ivec2(0x80000000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec2(0x80000000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  ivec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  ivec3 ref = ivec3(0x80000000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec3(0x80000000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  ivec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  ivec3 ref = ivec3(0x80000000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec3(0x80000000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  ivec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  ivec4 ref = ivec4(0x80000000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec4(0x80000000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  ivec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  ivec4 ref = ivec4(0x80000000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec4(0x80000000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<int, 8> ref = vector<int, 8>(0x80000000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int, 8>(0x80000000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<int, 8> ref = vector<int, 8>(0x80000000);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int, 8>(0x80000000);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  uint ref = uint(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  uint ref = uint(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uvec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  uvec2 ref = uvec2(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec2(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uvec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  uvec2 ref = uvec2(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec2(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uvec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  uvec3 ref = uvec3(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec3(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uvec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  uvec3 ref = uvec3(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec3(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uvec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  uvec4 ref = uvec4(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec4(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uvec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  uvec4 ref = uvec4(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec4(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<uint, 8> ref = vector<uint, 8>(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint, 8>(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<uint, 8> ref = vector<uint, 8>(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint, 8>(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int64_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  int64_t ref = int64_t(0x8000000000000000UL);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int64_t(0x8000000000000000UL);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int64_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  int64_t ref = int64_t(0x8000000000000000UL);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int64_t(0x8000000000000000UL);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i64vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i64vec2 ref = i64vec2(0x8000000000000000UL);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec2(0x8000000000000000UL);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i64vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i64vec2 ref = i64vec2(0x8000000000000000UL);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec2(0x8000000000000000UL);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i64vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i64vec3 ref = i64vec3(0x8000000000000000UL);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec3(0x8000000000000000UL);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i64vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i64vec3 ref = i64vec3(0x8000000000000000UL);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec3(0x8000000000000000UL);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i64vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i64vec4 ref = i64vec4(0x8000000000000000UL);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec4(0x8000000000000000UL);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i64vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  i64vec4 ref = i64vec4(0x8000000000000000UL);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec4(0x8000000000000000UL);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int64_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<int64_t, 8> ref = vector<int64_t, 8>(0x8000000000000000UL);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int64_t, 8>(0x8000000000000000UL);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int64_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<int64_t, 8> ref = vector<int64_t, 8>(0x8000000000000000UL);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int64_t, 8>(0x8000000000000000UL);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint64_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  uint64_t ref = uint64_t(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint64_t(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint64_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  uint64_t ref = uint64_t(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint64_t(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u64vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u64vec2 ref = u64vec2(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec2(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u64vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u64vec2 ref = u64vec2(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec2(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u64vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u64vec3 ref = u64vec3(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec3(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u64vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u64vec3 ref = u64vec3(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec3(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u64vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u64vec4 ref = u64vec4(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec4(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u64vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  u64vec4 ref = u64vec4(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec4(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint64_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<uint64_t, 8> ref = vector<uint64_t, 8>(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint64_t, 8>(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint64_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<uint64_t, 8> ref = vector<uint64_t, 8>(0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = max(ref, data[index]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint64_t, 8>(0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = max(ref, data[index]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  float16_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  float16_t ref = float16_t(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : max(ref, data[index])));
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = float16_t(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : max(ref, data[index])));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  float16_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  float16_t ref = float16_t(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : max(ref, data[index])));
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = float16_t(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : max(ref, data[index])));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  f16vec2 ref = f16vec2(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = f16vec2(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  f16vec2 ref = f16vec2(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = f16vec2(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  f16vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  f16vec3 ref = f16vec3(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = f16vec3(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  f16vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  f16vec3 ref = f16vec3(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = f16vec3(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  f16vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  f16vec4 ref = f16vec4(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = f16vec4(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  f16vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  f16vec4 ref = f16vec4(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = f16vec4(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<float16_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<float16_t, 8>(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<float16_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<float16_t, 8>(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  float data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  float ref = float(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : max(ref, data[index])));
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = float(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : max(ref, data[index])));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  float data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  float ref = float(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : max(ref, data[index])));
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = float(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : max(ref, data[index])));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vec2 ref = vec2(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vec2(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vec2 ref = vec2(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vec2(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vec3 ref = vec3(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vec3(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vec3 ref = vec3(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vec3(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vec4 ref = vec4(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vec4(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vec4 ref = vec4(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vec4(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<float, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<float, 8>(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<float, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<float, 8>(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  double data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  double ref = double(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : max(ref, data[index])));
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = double(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : max(ref, data[index])));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  double data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  double ref = double(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : max(ref, data[index])));
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = double(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : max(ref, data[index])));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupInclusiveMax(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  dvec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  dvec2 ref = dvec2(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = dvec2(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  dvec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  dvec2 ref = dvec2(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = dvec2(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  dvec3 ref = dvec3(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = dvec3(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  dvec3 ref = dvec3(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = dvec3(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  dvec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  dvec4 ref = dvec4(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = dvec4(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  dvec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  dvec4 ref = dvec4(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = dvec4(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<double, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<double, 8>(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<double, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint start = 0, end = gl_SubgroupInvocationID + 1;
  vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0xff800000));
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<double, 8>(intBitsToFloat(0xff800000));
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = mix(mix(max(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupInclusiveMax(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  tempRes |= identityOnly;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
