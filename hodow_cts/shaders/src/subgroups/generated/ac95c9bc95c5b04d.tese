#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uvec2 allResult = subgroupPartitionedMaxNV(data[gl_SubgroupInvocationID], allBallot);
  uvec2 refResult = subgroupMax(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uvec2 allResult = subgroupPartitionedMaxNV(data[gl_SubgroupInvocationID], allBallot);
    uvec2 refResult = subgroupMax(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uvec2 selfResult = subgroupPartitionedMaxNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uvec2 idhashFmt = uvec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uvec2 partitionedResult = subgroupPartitionedMaxNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uvec2 iFmt = uvec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          uvec2 subsetResult = subgroupMax(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uvec2 idhashFmt = uvec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uvec2 partitionedResult = subgroupPartitionedMaxNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uvec2 iFmt = uvec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            uvec2 subsetResult = subgroupMax(data[gl_SubgroupInvocationID]);
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
