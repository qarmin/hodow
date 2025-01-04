#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  int64_t data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  int64_t allResult = subgroupPartitionedInclusiveOrNV(data[gl_SubgroupInvocationID], allBallot);
  int64_t refResult = subgroupInclusiveOr(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    int64_t allResult = subgroupPartitionedInclusiveOrNV(data[gl_SubgroupInvocationID], allBallot);
    int64_t refResult = subgroupInclusiveOr(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  int64_t selfResult = subgroupPartitionedInclusiveOrNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    int64_t idhashFmt = int64_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    int64_t partitionedResult = subgroupPartitionedInclusiveOrNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        int64_t iFmt = int64_t(i);
        if ((idhashFmt == iFmt)) {
          int64_t subsetResult = subgroupInclusiveOr(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      int64_t idhashFmt = int64_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      int64_t partitionedResult = subgroupPartitionedInclusiveOrNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          int64_t iFmt = int64_t(i);
          if ((idhashFmt == iFmt)) {
            int64_t subsetResult = subgroupInclusiveOr(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result = tempRes;
}
