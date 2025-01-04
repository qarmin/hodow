#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vec4 allResult = subgroupPartitionedMulNV(data[gl_SubgroupInvocationID], allBallot);
  vec4 refResult = subgroupMul(data[gl_SubgroupInvocationID]);
  if (all(lessThan(abs(allResult - refResult), vec4(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vec4 allResult = subgroupPartitionedMulNV(data[gl_SubgroupInvocationID], allBallot);
    vec4 refResult = subgroupMul(data[gl_SubgroupInvocationID]);
    if (all(lessThan(abs(allResult - refResult), vec4(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vec4 selfResult = subgroupPartitionedMulNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(lessThan(abs(selfResult - data[gl_SubgroupInvocationID]), vec4(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vec4 idhashFmt = vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vec4 partitionedResult = subgroupPartitionedMulNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vec4 iFmt = vec4(i);
        if (all(lessThan(abs(idhashFmt - iFmt), vec4(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
          vec4 subsetResult = subgroupMul(data[gl_SubgroupInvocationID]);
          tempResult |= all(lessThan(abs(partitionedResult - subsetResult), vec4(gl_SubgroupSize==128 ? 0.000025: 0.00001))) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vec4 idhashFmt = vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vec4 partitionedResult = subgroupPartitionedMulNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vec4 iFmt = vec4(i);
          if (all(lessThan(abs(idhashFmt - iFmt), vec4(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
            vec4 subsetResult = subgroupMul(data[gl_SubgroupInvocationID]);
            tempResult |= all(lessThan(abs(partitionedResult - subsetResult), vec4(gl_SubgroupSize==128 ? 0.000025: 0.00001))) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
