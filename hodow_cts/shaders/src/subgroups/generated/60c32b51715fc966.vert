#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  int8_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  int8_t allResult = subgroupPartitionedInclusiveAndNV(data[gl_SubgroupInvocationID], allBallot);
  int8_t refResult = subgroupInclusiveAnd(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    int8_t allResult = subgroupPartitionedInclusiveAndNV(data[gl_SubgroupInvocationID], allBallot);
    int8_t refResult = subgroupInclusiveAnd(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  int8_t selfResult = subgroupPartitionedInclusiveAndNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    int8_t idhashFmt = int8_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    int8_t partitionedResult = subgroupPartitionedInclusiveAndNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        int8_t iFmt = int8_t(i);
        if ((idhashFmt == iFmt)) {
          int8_t subsetResult = subgroupInclusiveAnd(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      int8_t idhashFmt = int8_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      int8_t partitionedResult = subgroupPartitionedInclusiveAndNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          int8_t iFmt = int8_t(i);
          if ((idhashFmt == iFmt)) {
            int8_t subsetResult = subgroupInclusiveAnd(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
