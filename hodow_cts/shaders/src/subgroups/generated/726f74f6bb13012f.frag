#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vec2 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vec2 allResult = subgroupPartitionedInclusiveMulNV(data[gl_SubgroupInvocationID], allBallot);
  vec2 refResult = subgroupInclusiveMul(data[gl_SubgroupInvocationID]);
  if (all(lessThan(abs(allResult - refResult), vec2(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vec2 allResult = subgroupPartitionedInclusiveMulNV(data[gl_SubgroupInvocationID], allBallot);
    vec2 refResult = subgroupInclusiveMul(data[gl_SubgroupInvocationID]);
    if (all(lessThan(abs(allResult - refResult), vec2(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vec2 selfResult = subgroupPartitionedInclusiveMulNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(lessThan(abs(selfResult - data[gl_SubgroupInvocationID]), vec2(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vec2 idhashFmt = vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vec2 partitionedResult = subgroupPartitionedInclusiveMulNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vec2 iFmt = vec2(i);
        if (all(lessThan(abs(idhashFmt - iFmt), vec2(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
          vec2 subsetResult = subgroupInclusiveMul(data[gl_SubgroupInvocationID]);
          tempResult |= all(lessThan(abs(partitionedResult - subsetResult), vec2(gl_SubgroupSize==128 ? 0.000025: 0.00001))) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vec2 idhashFmt = vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vec2 partitionedResult = subgroupPartitionedInclusiveMulNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vec2 iFmt = vec2(i);
          if (all(lessThan(abs(idhashFmt - iFmt), vec2(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
            vec2 subsetResult = subgroupInclusiveMul(data[gl_SubgroupInvocationID]);
            tempResult |= all(lessThan(abs(partitionedResult - subsetResult), vec2(gl_SubgroupSize==128 ? 0.000025: 0.00001))) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result = tempRes;
}
