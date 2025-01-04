#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vec4 allResult = subgroupPartitionedExclusiveMaxNV(data[gl_SubgroupInvocationID], allBallot);
  vec4 refResult = subgroupExclusiveMax(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vec4 allResult = subgroupPartitionedExclusiveMaxNV(data[gl_SubgroupInvocationID], allBallot);
    vec4 refResult = subgroupExclusiveMax(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vec4 selfResult = subgroupPartitionedExclusiveMaxNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, vec4(intBitsToFloat(0xff800000))))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vec4 idhashFmt = vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vec4 partitionedResult = subgroupPartitionedExclusiveMaxNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vec4 iFmt = vec4(i);
        if (all(equal(idhashFmt, iFmt))) {
          vec4 subsetResult = subgroupExclusiveMax(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vec4 idhashFmt = vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vec4 partitionedResult = subgroupPartitionedExclusiveMaxNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vec4 iFmt = vec4(i);
          if (all(equal(idhashFmt, iFmt))) {
            vec4 subsetResult = subgroupExclusiveMax(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
