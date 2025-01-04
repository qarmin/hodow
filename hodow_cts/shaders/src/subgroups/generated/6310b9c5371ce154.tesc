#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<uint16_t, 8> allResult = subgroupPartitionedExclusiveAddNV(data[gl_SubgroupInvocationID], allBallot);
  vector<uint16_t, 8> refResult = subgroupExclusiveAdd(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<uint16_t, 8> allResult = subgroupPartitionedExclusiveAddNV(data[gl_SubgroupInvocationID], allBallot);
    vector<uint16_t, 8> refResult = subgroupExclusiveAdd(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<uint16_t, 8> selfResult = subgroupPartitionedExclusiveAddNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, vector<uint16_t, 8>(0)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<uint16_t, 8> idhashFmt = vector<uint16_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<uint16_t, 8> partitionedResult = subgroupPartitionedExclusiveAddNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<uint16_t, 8> iFmt = vector<uint16_t, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<uint16_t, 8> subsetResult = subgroupExclusiveAdd(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<uint16_t, 8> idhashFmt = vector<uint16_t, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<uint16_t, 8> partitionedResult = subgroupPartitionedExclusiveAddNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<uint16_t, 8> iFmt = vector<uint16_t, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<uint16_t, 8> subsetResult = subgroupExclusiveAdd(data[gl_SubgroupInvocationID]);
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
