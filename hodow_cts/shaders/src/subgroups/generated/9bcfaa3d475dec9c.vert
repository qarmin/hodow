#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vec2 allResult = subgroupPartitionedExclusiveMaxNV(data[gl_SubgroupInvocationID], allBallot);
  vec2 refResult = subgroupExclusiveMax(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vec2 allResult = subgroupPartitionedExclusiveMaxNV(data[gl_SubgroupInvocationID], allBallot);
    vec2 refResult = subgroupExclusiveMax(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vec2 selfResult = subgroupPartitionedExclusiveMaxNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, vec2(intBitsToFloat(0xff800000))))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vec2 idhashFmt = vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vec2 partitionedResult = subgroupPartitionedExclusiveMaxNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vec2 iFmt = vec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          vec2 subsetResult = subgroupExclusiveMax(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vec2 idhashFmt = vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vec2 partitionedResult = subgroupPartitionedExclusiveMaxNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vec2 iFmt = vec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            vec2 subsetResult = subgroupExclusiveMax(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
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
