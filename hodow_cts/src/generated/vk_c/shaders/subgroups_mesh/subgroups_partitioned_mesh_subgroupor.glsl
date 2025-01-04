#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  int8_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  int8_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    int8_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    int8_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  int8_t selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    int8_t idhashFmt = int8_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    int8_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        int8_t iFmt = int8_t(i);
        if ((idhashFmt == iFmt)) {
          int8_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      int8_t idhashFmt = int8_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      int8_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          int8_t iFmt = int8_t(i);
          if ((idhashFmt == iFmt)) {
            int8_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  int8_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  int8_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    int8_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    int8_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  int8_t selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    int8_t idhashFmt = int8_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    int8_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        int8_t iFmt = int8_t(i);
        if ((idhashFmt == iFmt)) {
          int8_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      int8_t idhashFmt = int8_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      int8_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          int8_t iFmt = int8_t(i);
          if ((idhashFmt == iFmt)) {
            int8_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
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
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i8vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i8vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i8vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i8vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i8vec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i8vec2 idhashFmt = i8vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i8vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i8vec2 iFmt = i8vec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          i8vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i8vec2 idhashFmt = i8vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i8vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i8vec2 iFmt = i8vec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            i8vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i8vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i8vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i8vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i8vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i8vec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i8vec2 idhashFmt = i8vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i8vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i8vec2 iFmt = i8vec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          i8vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i8vec2 idhashFmt = i8vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i8vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i8vec2 iFmt = i8vec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            i8vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i8vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i8vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i8vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i8vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i8vec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i8vec3 idhashFmt = i8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i8vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i8vec3 iFmt = i8vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          i8vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i8vec3 idhashFmt = i8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i8vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i8vec3 iFmt = i8vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            i8vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i8vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i8vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i8vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i8vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i8vec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i8vec3 idhashFmt = i8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i8vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i8vec3 iFmt = i8vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          i8vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i8vec3 idhashFmt = i8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i8vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i8vec3 iFmt = i8vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            i8vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i8vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i8vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i8vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i8vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i8vec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i8vec4 idhashFmt = i8vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i8vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i8vec4 iFmt = i8vec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          i8vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i8vec4 idhashFmt = i8vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i8vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i8vec4 iFmt = i8vec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            i8vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i8vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i8vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i8vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i8vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i8vec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i8vec4 idhashFmt = i8vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i8vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i8vec4 iFmt = i8vec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          i8vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i8vec4 idhashFmt = i8vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i8vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i8vec4 iFmt = i8vec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            i8vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<int8_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<int8_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<int8_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<int8_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<int8_t, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<int8_t, 8> idhashFmt = vector<int8_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<int8_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<int8_t, 8> iFmt = vector<int8_t, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<int8_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<int8_t, 8> idhashFmt = vector<int8_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<int8_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<int8_t, 8> iFmt = vector<int8_t, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<int8_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<int8_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<int8_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<int8_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<int8_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<int8_t, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<int8_t, 8> idhashFmt = vector<int8_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<int8_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<int8_t, 8> iFmt = vector<int8_t, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<int8_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<int8_t, 8> idhashFmt = vector<int8_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<int8_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<int8_t, 8> iFmt = vector<int8_t, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<int8_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uint8_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  uint8_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uint8_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    uint8_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uint8_t selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uint8_t idhashFmt = uint8_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uint8_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uint8_t iFmt = uint8_t(i);
        if ((idhashFmt == iFmt)) {
          uint8_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uint8_t idhashFmt = uint8_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uint8_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uint8_t iFmt = uint8_t(i);
          if ((idhashFmt == iFmt)) {
            uint8_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uint8_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  uint8_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uint8_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    uint8_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uint8_t selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uint8_t idhashFmt = uint8_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uint8_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uint8_t iFmt = uint8_t(i);
        if ((idhashFmt == iFmt)) {
          uint8_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uint8_t idhashFmt = uint8_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uint8_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uint8_t iFmt = uint8_t(i);
          if ((idhashFmt == iFmt)) {
            uint8_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec2 idhashFmt = u8vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec2 iFmt = u8vec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec2 idhashFmt = u8vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec2 iFmt = u8vec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec2 idhashFmt = u8vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec2 iFmt = u8vec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec2 idhashFmt = u8vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec2 iFmt = u8vec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec3 iFmt = u8vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec3 iFmt = u8vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec3 iFmt = u8vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec3 iFmt = u8vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec4 idhashFmt = u8vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec4 iFmt = u8vec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec4 idhashFmt = u8vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec4 iFmt = u8vec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec4 idhashFmt = u8vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec4 iFmt = u8vec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec4 idhashFmt = u8vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec4 iFmt = u8vec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<uint8_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<uint8_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<uint8_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<uint8_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<uint8_t, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<uint8_t, 8> idhashFmt = vector<uint8_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<uint8_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<uint8_t, 8> iFmt = vector<uint8_t, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<uint8_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<uint8_t, 8> idhashFmt = vector<uint8_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<uint8_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<uint8_t, 8> iFmt = vector<uint8_t, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<uint8_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<uint8_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<uint8_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<uint8_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<uint8_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<uint8_t, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<uint8_t, 8> idhashFmt = vector<uint8_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<uint8_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<uint8_t, 8> iFmt = vector<uint8_t, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<uint8_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<uint8_t, 8> idhashFmt = vector<uint8_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<uint8_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<uint8_t, 8> iFmt = vector<uint8_t, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<uint8_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  int16_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  int16_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    int16_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    int16_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  int16_t selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    int16_t idhashFmt = int16_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    int16_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        int16_t iFmt = int16_t(i);
        if ((idhashFmt == iFmt)) {
          int16_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      int16_t idhashFmt = int16_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      int16_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          int16_t iFmt = int16_t(i);
          if ((idhashFmt == iFmt)) {
            int16_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  int16_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  int16_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    int16_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    int16_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  int16_t selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    int16_t idhashFmt = int16_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    int16_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        int16_t iFmt = int16_t(i);
        if ((idhashFmt == iFmt)) {
          int16_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      int16_t idhashFmt = int16_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      int16_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          int16_t iFmt = int16_t(i);
          if ((idhashFmt == iFmt)) {
            int16_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i16vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i16vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i16vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i16vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i16vec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i16vec2 idhashFmt = i16vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i16vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i16vec2 iFmt = i16vec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          i16vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i16vec2 idhashFmt = i16vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i16vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i16vec2 iFmt = i16vec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            i16vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i16vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i16vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i16vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i16vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i16vec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i16vec2 idhashFmt = i16vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i16vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i16vec2 iFmt = i16vec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          i16vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i16vec2 idhashFmt = i16vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i16vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i16vec2 iFmt = i16vec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            i16vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i16vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i16vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i16vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i16vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i16vec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i16vec3 idhashFmt = i16vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i16vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i16vec3 iFmt = i16vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          i16vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i16vec3 idhashFmt = i16vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i16vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i16vec3 iFmt = i16vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            i16vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i16vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i16vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i16vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i16vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i16vec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i16vec3 idhashFmt = i16vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i16vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i16vec3 iFmt = i16vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          i16vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i16vec3 idhashFmt = i16vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i16vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i16vec3 iFmt = i16vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            i16vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i16vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i16vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i16vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i16vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i16vec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i16vec4 idhashFmt = i16vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i16vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i16vec4 iFmt = i16vec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          i16vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i16vec4 idhashFmt = i16vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i16vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i16vec4 iFmt = i16vec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            i16vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i16vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i16vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i16vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i16vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i16vec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i16vec4 idhashFmt = i16vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i16vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i16vec4 iFmt = i16vec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          i16vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i16vec4 idhashFmt = i16vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i16vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i16vec4 iFmt = i16vec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            i16vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<int16_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<int16_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<int16_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<int16_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<int16_t, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<int16_t, 8> idhashFmt = vector<int16_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<int16_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<int16_t, 8> iFmt = vector<int16_t, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<int16_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<int16_t, 8> idhashFmt = vector<int16_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<int16_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<int16_t, 8> iFmt = vector<int16_t, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<int16_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<int16_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<int16_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<int16_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<int16_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<int16_t, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<int16_t, 8> idhashFmt = vector<int16_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<int16_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<int16_t, 8> iFmt = vector<int16_t, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<int16_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<int16_t, 8> idhashFmt = vector<int16_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<int16_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<int16_t, 8> iFmt = vector<int16_t, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<int16_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uint16_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  uint16_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uint16_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    uint16_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uint16_t selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uint16_t idhashFmt = uint16_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uint16_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uint16_t iFmt = uint16_t(i);
        if ((idhashFmt == iFmt)) {
          uint16_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uint16_t idhashFmt = uint16_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uint16_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uint16_t iFmt = uint16_t(i);
          if ((idhashFmt == iFmt)) {
            uint16_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uint16_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  uint16_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uint16_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    uint16_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uint16_t selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uint16_t idhashFmt = uint16_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uint16_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uint16_t iFmt = uint16_t(i);
        if ((idhashFmt == iFmt)) {
          uint16_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uint16_t idhashFmt = uint16_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uint16_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uint16_t iFmt = uint16_t(i);
          if ((idhashFmt == iFmt)) {
            uint16_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u16vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u16vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u16vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u16vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u16vec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u16vec2 idhashFmt = u16vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u16vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u16vec2 iFmt = u16vec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          u16vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u16vec2 idhashFmt = u16vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u16vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u16vec2 iFmt = u16vec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            u16vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u16vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u16vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u16vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u16vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u16vec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u16vec2 idhashFmt = u16vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u16vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u16vec2 iFmt = u16vec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          u16vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u16vec2 idhashFmt = u16vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u16vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u16vec2 iFmt = u16vec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            u16vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u16vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u16vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u16vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u16vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u16vec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u16vec3 idhashFmt = u16vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u16vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u16vec3 iFmt = u16vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u16vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u16vec3 idhashFmt = u16vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u16vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u16vec3 iFmt = u16vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u16vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u16vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u16vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u16vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u16vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u16vec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u16vec3 idhashFmt = u16vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u16vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u16vec3 iFmt = u16vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u16vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u16vec3 idhashFmt = u16vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u16vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u16vec3 iFmt = u16vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u16vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u16vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u16vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u16vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u16vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u16vec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u16vec4 idhashFmt = u16vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u16vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u16vec4 iFmt = u16vec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          u16vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u16vec4 idhashFmt = u16vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u16vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u16vec4 iFmt = u16vec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            u16vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u16vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u16vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u16vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u16vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u16vec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u16vec4 idhashFmt = u16vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u16vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u16vec4 iFmt = u16vec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          u16vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u16vec4 idhashFmt = u16vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u16vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u16vec4 iFmt = u16vec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            u16vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<uint16_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<uint16_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<uint16_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<uint16_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<uint16_t, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<uint16_t, 8> idhashFmt = vector<uint16_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<uint16_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<uint16_t, 8> iFmt = vector<uint16_t, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<uint16_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<uint16_t, 8> idhashFmt = vector<uint16_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<uint16_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<uint16_t, 8> iFmt = vector<uint16_t, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<uint16_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<uint16_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<uint16_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<uint16_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<uint16_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<uint16_t, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<uint16_t, 8> idhashFmt = vector<uint16_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<uint16_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<uint16_t, 8> iFmt = vector<uint16_t, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<uint16_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<uint16_t, 8> idhashFmt = vector<uint16_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<uint16_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<uint16_t, 8> iFmt = vector<uint16_t, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<uint16_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  int allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  int refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    int allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    int refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  int selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    int idhashFmt = int(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    int partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        int iFmt = int(i);
        if ((idhashFmt == iFmt)) {
          int subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      int idhashFmt = int(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      int partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          int iFmt = int(i);
          if ((idhashFmt == iFmt)) {
            int subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  int allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  int refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    int allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    int refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  int selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    int idhashFmt = int(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    int partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        int iFmt = int(i);
        if ((idhashFmt == iFmt)) {
          int subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      int idhashFmt = int(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      int partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          int iFmt = int(i);
          if ((idhashFmt == iFmt)) {
            int subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  ivec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  ivec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    ivec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    ivec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  ivec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    ivec2 idhashFmt = ivec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    ivec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        ivec2 iFmt = ivec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          ivec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      ivec2 idhashFmt = ivec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      ivec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          ivec2 iFmt = ivec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            ivec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  ivec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  ivec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    ivec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    ivec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  ivec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    ivec2 idhashFmt = ivec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    ivec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        ivec2 iFmt = ivec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          ivec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      ivec2 idhashFmt = ivec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      ivec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          ivec2 iFmt = ivec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            ivec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  ivec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  ivec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    ivec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    ivec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  ivec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    ivec3 idhashFmt = ivec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    ivec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        ivec3 iFmt = ivec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          ivec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      ivec3 idhashFmt = ivec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      ivec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          ivec3 iFmt = ivec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            ivec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  ivec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  ivec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    ivec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    ivec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  ivec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    ivec3 idhashFmt = ivec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    ivec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        ivec3 iFmt = ivec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          ivec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      ivec3 idhashFmt = ivec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      ivec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          ivec3 iFmt = ivec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            ivec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  ivec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  ivec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    ivec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    ivec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  ivec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    ivec4 idhashFmt = ivec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    ivec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        ivec4 iFmt = ivec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          ivec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      ivec4 idhashFmt = ivec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      ivec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          ivec4 iFmt = ivec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            ivec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  ivec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  ivec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    ivec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    ivec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  ivec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    ivec4 idhashFmt = ivec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    ivec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        ivec4 iFmt = ivec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          ivec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      ivec4 idhashFmt = ivec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      ivec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          ivec4 iFmt = ivec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            ivec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<int, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<int, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<int, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<int, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<int, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<int, 8> idhashFmt = vector<int, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<int, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<int, 8> iFmt = vector<int, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<int, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<int, 8> idhashFmt = vector<int, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<int, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<int, 8> iFmt = vector<int, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<int, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<int, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<int, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<int, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<int, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<int, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<int, 8> idhashFmt = vector<int, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<int, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<int, 8> iFmt = vector<int, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<int, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<int, 8> idhashFmt = vector<int, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<int, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<int, 8> iFmt = vector<int, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<int, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uint allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  uint refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uint allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    uint refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uint selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uint idhashFmt = uint(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uint partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uint iFmt = uint(i);
        if ((idhashFmt == iFmt)) {
          uint subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uint idhashFmt = uint(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uint partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uint iFmt = uint(i);
          if ((idhashFmt == iFmt)) {
            uint subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uint allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  uint refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uint allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    uint refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uint selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uint idhashFmt = uint(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uint partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uint iFmt = uint(i);
        if ((idhashFmt == iFmt)) {
          uint subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uint idhashFmt = uint(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uint partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uint iFmt = uint(i);
          if ((idhashFmt == iFmt)) {
            uint subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uvec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  uvec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uvec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    uvec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uvec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uvec2 idhashFmt = uvec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uvec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uvec2 iFmt = uvec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          uvec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uvec2 idhashFmt = uvec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uvec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uvec2 iFmt = uvec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            uvec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uvec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  uvec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uvec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    uvec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uvec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uvec2 idhashFmt = uvec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uvec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uvec2 iFmt = uvec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          uvec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uvec2 idhashFmt = uvec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uvec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uvec2 iFmt = uvec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            uvec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uvec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  uvec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uvec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    uvec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uvec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uvec3 idhashFmt = uvec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uvec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uvec3 iFmt = uvec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          uvec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uvec3 idhashFmt = uvec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uvec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uvec3 iFmt = uvec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            uvec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uvec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  uvec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uvec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    uvec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uvec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uvec3 idhashFmt = uvec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uvec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uvec3 iFmt = uvec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          uvec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uvec3 idhashFmt = uvec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uvec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uvec3 iFmt = uvec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            uvec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uvec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  uvec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uvec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    uvec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uvec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uvec4 idhashFmt = uvec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uvec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uvec4 iFmt = uvec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          uvec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uvec4 idhashFmt = uvec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uvec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uvec4 iFmt = uvec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            uvec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uvec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  uvec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uvec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    uvec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uvec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uvec4 idhashFmt = uvec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uvec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uvec4 iFmt = uvec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          uvec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uvec4 idhashFmt = uvec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uvec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uvec4 iFmt = uvec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            uvec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<uint, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<uint, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<uint, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<uint, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<uint, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<uint, 8> idhashFmt = vector<uint, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<uint, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<uint, 8> iFmt = vector<uint, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<uint, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<uint, 8> idhashFmt = vector<uint, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<uint, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<uint, 8> iFmt = vector<uint, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<uint, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<uint, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<uint, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<uint, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<uint, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<uint, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<uint, 8> idhashFmt = vector<uint, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<uint, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<uint, 8> iFmt = vector<uint, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<uint, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<uint, 8> idhashFmt = vector<uint, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<uint, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<uint, 8> iFmt = vector<uint, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<uint, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  int64_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  int64_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    int64_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    int64_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  int64_t selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    int64_t idhashFmt = int64_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    int64_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        int64_t iFmt = int64_t(i);
        if ((idhashFmt == iFmt)) {
          int64_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      int64_t idhashFmt = int64_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      int64_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          int64_t iFmt = int64_t(i);
          if ((idhashFmt == iFmt)) {
            int64_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  int64_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  int64_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    int64_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    int64_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  int64_t selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    int64_t idhashFmt = int64_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    int64_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        int64_t iFmt = int64_t(i);
        if ((idhashFmt == iFmt)) {
          int64_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      int64_t idhashFmt = int64_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      int64_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          int64_t iFmt = int64_t(i);
          if ((idhashFmt == iFmt)) {
            int64_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i64vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i64vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i64vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i64vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i64vec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i64vec2 idhashFmt = i64vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i64vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i64vec2 iFmt = i64vec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          i64vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i64vec2 idhashFmt = i64vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i64vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i64vec2 iFmt = i64vec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            i64vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i64vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i64vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i64vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i64vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i64vec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i64vec2 idhashFmt = i64vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i64vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i64vec2 iFmt = i64vec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          i64vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i64vec2 idhashFmt = i64vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i64vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i64vec2 iFmt = i64vec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            i64vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i64vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i64vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i64vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i64vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i64vec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i64vec3 idhashFmt = i64vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i64vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i64vec3 iFmt = i64vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          i64vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i64vec3 idhashFmt = i64vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i64vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i64vec3 iFmt = i64vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            i64vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i64vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i64vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i64vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i64vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i64vec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i64vec3 idhashFmt = i64vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i64vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i64vec3 iFmt = i64vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          i64vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i64vec3 idhashFmt = i64vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i64vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i64vec3 iFmt = i64vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            i64vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i64vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i64vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i64vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i64vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i64vec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i64vec4 idhashFmt = i64vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i64vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i64vec4 iFmt = i64vec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          i64vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i64vec4 idhashFmt = i64vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i64vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i64vec4 iFmt = i64vec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            i64vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i64vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  i64vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i64vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    i64vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i64vec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i64vec4 idhashFmt = i64vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i64vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i64vec4 iFmt = i64vec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          i64vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i64vec4 idhashFmt = i64vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i64vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i64vec4 iFmt = i64vec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            i64vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<int64_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<int64_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<int64_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<int64_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<int64_t, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<int64_t, 8> idhashFmt = vector<int64_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<int64_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<int64_t, 8> iFmt = vector<int64_t, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<int64_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<int64_t, 8> idhashFmt = vector<int64_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<int64_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<int64_t, 8> iFmt = vector<int64_t, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<int64_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<int64_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<int64_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<int64_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<int64_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<int64_t, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<int64_t, 8> idhashFmt = vector<int64_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<int64_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<int64_t, 8> iFmt = vector<int64_t, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<int64_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<int64_t, 8> idhashFmt = vector<int64_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<int64_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<int64_t, 8> iFmt = vector<int64_t, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<int64_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uint64_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  uint64_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uint64_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    uint64_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uint64_t selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uint64_t idhashFmt = uint64_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uint64_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uint64_t iFmt = uint64_t(i);
        if ((idhashFmt == iFmt)) {
          uint64_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uint64_t idhashFmt = uint64_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uint64_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uint64_t iFmt = uint64_t(i);
          if ((idhashFmt == iFmt)) {
            uint64_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uint64_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  uint64_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uint64_t allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    uint64_t refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uint64_t selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uint64_t idhashFmt = uint64_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uint64_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uint64_t iFmt = uint64_t(i);
        if ((idhashFmt == iFmt)) {
          uint64_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uint64_t idhashFmt = uint64_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uint64_t partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uint64_t iFmt = uint64_t(i);
          if ((idhashFmt == iFmt)) {
            uint64_t subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u64vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u64vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u64vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u64vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u64vec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u64vec2 idhashFmt = u64vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u64vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u64vec2 iFmt = u64vec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          u64vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u64vec2 idhashFmt = u64vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u64vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u64vec2 iFmt = u64vec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            u64vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u64vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u64vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u64vec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u64vec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u64vec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u64vec2 idhashFmt = u64vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u64vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u64vec2 iFmt = u64vec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          u64vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u64vec2 idhashFmt = u64vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u64vec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u64vec2 iFmt = u64vec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            u64vec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u64vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u64vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u64vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u64vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u64vec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u64vec3 idhashFmt = u64vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u64vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u64vec3 iFmt = u64vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u64vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u64vec3 idhashFmt = u64vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u64vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u64vec3 iFmt = u64vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u64vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u64vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u64vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u64vec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u64vec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u64vec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u64vec3 idhashFmt = u64vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u64vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u64vec3 iFmt = u64vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u64vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u64vec3 idhashFmt = u64vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u64vec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u64vec3 iFmt = u64vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u64vec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u64vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u64vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u64vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u64vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u64vec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u64vec4 idhashFmt = u64vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u64vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u64vec4 iFmt = u64vec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          u64vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u64vec4 idhashFmt = u64vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u64vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u64vec4 iFmt = u64vec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            u64vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u64vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  u64vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u64vec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    u64vec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u64vec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u64vec4 idhashFmt = u64vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u64vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u64vec4 iFmt = u64vec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          u64vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u64vec4 idhashFmt = u64vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u64vec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u64vec4 iFmt = u64vec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            u64vec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<uint64_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<uint64_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<uint64_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<uint64_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<uint64_t, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<uint64_t, 8> idhashFmt = vector<uint64_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<uint64_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<uint64_t, 8> iFmt = vector<uint64_t, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<uint64_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<uint64_t, 8> idhashFmt = vector<uint64_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<uint64_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<uint64_t, 8> iFmt = vector<uint64_t, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<uint64_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<uint64_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<uint64_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<uint64_t, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<uint64_t, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<uint64_t, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<uint64_t, 8> idhashFmt = vector<uint64_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<uint64_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<uint64_t, 8> iFmt = vector<uint64_t, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<uint64_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<uint64_t, 8> idhashFmt = vector<uint64_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<uint64_t, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<uint64_t, 8> iFmt = vector<uint64_t, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<uint64_t, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  bool data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  bool allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  bool refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    bool allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    bool refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  bool selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    bool idhashFmt = bool(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    bool partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        bool iFmt = bool(i);
        if ((idhashFmt == iFmt)) {
          bool subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      bool idhashFmt = bool(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      bool partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          bool iFmt = bool(i);
          if ((idhashFmt == iFmt)) {
            bool subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  bool data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  bool allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  bool refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    bool allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    bool refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  bool selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    bool idhashFmt = bool(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    bool partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        bool iFmt = bool(i);
        if ((idhashFmt == iFmt)) {
          bool subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      bool idhashFmt = bool(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      bool partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          bool iFmt = bool(i);
          if ((idhashFmt == iFmt)) {
            bool subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  bvec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  bvec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  bvec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    bvec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    bvec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  bvec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    bvec2 idhashFmt = bvec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    bvec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        bvec2 iFmt = bvec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          bvec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      bvec2 idhashFmt = bvec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      bvec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          bvec2 iFmt = bvec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            bvec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  bvec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  bvec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  bvec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    bvec2 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    bvec2 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  bvec2 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    bvec2 idhashFmt = bvec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    bvec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        bvec2 iFmt = bvec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          bvec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      bvec2 idhashFmt = bvec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      bvec2 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          bvec2 iFmt = bvec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            bvec2 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  bvec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  bvec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  bvec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    bvec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    bvec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  bvec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    bvec3 idhashFmt = bvec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    bvec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        bvec3 iFmt = bvec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          bvec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      bvec3 idhashFmt = bvec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      bvec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          bvec3 iFmt = bvec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            bvec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  bvec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  bvec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  bvec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    bvec3 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    bvec3 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  bvec3 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    bvec3 idhashFmt = bvec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    bvec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        bvec3 iFmt = bvec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          bvec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      bvec3 idhashFmt = bvec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      bvec3 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          bvec3 iFmt = bvec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            bvec3 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  bvec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  bvec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  bvec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    bvec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    bvec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  bvec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    bvec4 idhashFmt = bvec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    bvec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        bvec4 iFmt = bvec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          bvec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      bvec4 idhashFmt = bvec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      bvec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          bvec4 iFmt = bvec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            bvec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  bvec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  bvec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  bvec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    bvec4 allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    bvec4 refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  bvec4 selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    bvec4 idhashFmt = bvec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    bvec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        bvec4 iFmt = bvec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          bvec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      bvec4 idhashFmt = bvec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      bvec4 partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          bvec4 iFmt = bvec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            bvec4 subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  vector<bool, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<bool, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<bool, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<bool, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<bool, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<bool, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<bool, 8> idhashFmt = vector<bool, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<bool, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<bool, 8> iFmt = vector<bool, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<bool, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<bool, 8> idhashFmt = vector<bool, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<bool, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<bool, 8> iFmt = vector<bool, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<bool, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_NV_shader_subgroup_partitioned: enable
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
  vector<bool, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<bool, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
  vector<bool, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<bool, 8> allResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], allBallot);
    vector<bool, 8> refResult = subgroupOr(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<bool, 8> selfResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<bool, 8> idhashFmt = vector<bool, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<bool, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<bool, 8> iFmt = vector<bool, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<bool, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<bool, 8> idhashFmt = vector<bool, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<bool, 8> partitionedResult = subgroupPartitionedOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<bool, 8> iFmt = vector<bool, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<bool, 8> subsetResult = subgroupOr(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
