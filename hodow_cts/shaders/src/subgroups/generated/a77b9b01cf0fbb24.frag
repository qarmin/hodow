#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  ivec3 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  ivec3 allResult = subgroupPartitionedExclusiveMinNV(data[gl_SubgroupInvocationID], allBallot);
  ivec3 refResult = subgroupExclusiveMin(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    ivec3 allResult = subgroupPartitionedExclusiveMinNV(data[gl_SubgroupInvocationID], allBallot);
    ivec3 refResult = subgroupExclusiveMin(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  ivec3 selfResult = subgroupPartitionedExclusiveMinNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, ivec3(0x7fffffff)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    ivec3 idhashFmt = ivec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    ivec3 partitionedResult = subgroupPartitionedExclusiveMinNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        ivec3 iFmt = ivec3(i);
        if (all(equal(idhashFmt, iFmt))) {
          ivec3 subsetResult = subgroupExclusiveMin(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      ivec3 idhashFmt = ivec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      ivec3 partitionedResult = subgroupPartitionedExclusiveMinNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          ivec3 iFmt = ivec3(i);
          if (all(equal(idhashFmt, iFmt))) {
            ivec3 subsetResult = subgroupExclusiveMin(data[gl_SubgroupInvocationID]);
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
