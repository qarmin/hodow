#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  uint allResult = subgroupPartitionedMulNV(data[gl_SubgroupInvocationID], allBallot);
  uint refResult = subgroupMul(data[gl_SubgroupInvocationID]);
  if ((allResult == refResult)) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    uint allResult = subgroupPartitionedMulNV(data[gl_SubgroupInvocationID], allBallot);
    uint refResult = subgroupMul(data[gl_SubgroupInvocationID]);
    if ((allResult == refResult)) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  uint selfResult = subgroupPartitionedMulNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((selfResult == data[gl_SubgroupInvocationID])) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    uint idhashFmt = uint(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    uint partitionedResult = subgroupPartitionedMulNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        uint iFmt = uint(i);
        if ((idhashFmt == iFmt)) {
          uint subsetResult = subgroupMul(data[gl_SubgroupInvocationID]);
          tempResult |= (partitionedResult == subsetResult) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      uint idhashFmt = uint(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      uint partitionedResult = subgroupPartitionedMulNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          uint iFmt = uint(i);
          if ((idhashFmt == iFmt)) {
            uint subsetResult = subgroupMul(data[gl_SubgroupInvocationID]);
            tempResult |= (partitionedResult == subsetResult) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
