#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec3 selfResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, u8vec3(0)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec3 iFmt = u8vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec3 iFmt = u8vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec3 selfResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, u8vec3(0)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec3 iFmt = u8vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec3 iFmt = u8vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec3 selfResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, u8vec3(0)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec3 iFmt = u8vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec3 iFmt = u8vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec3 selfResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, u8vec3(0)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec3 iFmt = u8vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec3 iFmt = u8vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec3 selfResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, u8vec3(0)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec3 iFmt = u8vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec3 iFmt = u8vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec3 selfResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, u8vec3(0)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec3 iFmt = u8vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec3 iFmt = u8vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec3 selfResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, u8vec3(0)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec3 iFmt = u8vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec3 iFmt = u8vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec3 selfResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, u8vec3(0)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec3 iFmt = u8vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec3 iFmt = u8vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec3 selfResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, u8vec3(0)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec3 iFmt = u8vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec3 iFmt = u8vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  u8vec3 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
  u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    u8vec3 allResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], allBallot);
    u8vec3 refResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  u8vec3 selfResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, u8vec3(0)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        u8vec3 iFmt = u8vec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      u8vec3 idhashFmt = u8vec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      u8vec3 partitionedResult = subgroupPartitionedExclusiveXorNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          u8vec3 iFmt = u8vec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            u8vec3 subsetResult = subgroupExclusiveXor(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result = tempRes;
}
