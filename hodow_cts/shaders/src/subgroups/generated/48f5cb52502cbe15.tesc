#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  f16vec2 allResult = subgroupPartitionedExclusiveMulNV(data[gl_SubgroupInvocationID], allBallot);
  f16vec2 refResult = subgroupExclusiveMul(data[gl_SubgroupInvocationID]);
  if (all(lessThan(abs(allResult - refResult), f16vec2(gl_SubgroupSize==128 ? 0.2: 0.1)))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    f16vec2 allResult = subgroupPartitionedExclusiveMulNV(data[gl_SubgroupInvocationID], allBallot);
    f16vec2 refResult = subgroupExclusiveMul(data[gl_SubgroupInvocationID]);
    if (all(lessThan(abs(allResult - refResult), f16vec2(gl_SubgroupSize==128 ? 0.2: 0.1)))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  f16vec2 selfResult = subgroupPartitionedExclusiveMulNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(lessThan(abs(selfResult - f16vec2(1)), f16vec2(gl_SubgroupSize==128 ? 0.2: 0.1)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    f16vec2 idhashFmt = f16vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    f16vec2 partitionedResult = subgroupPartitionedExclusiveMulNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        f16vec2 iFmt = f16vec2(i);
        if (all(lessThan(abs(idhashFmt - iFmt), f16vec2(gl_SubgroupSize==128 ? 0.2: 0.1)))) {
          f16vec2 subsetResult = subgroupExclusiveMul(data[gl_SubgroupInvocationID]);
          tempResult |= all(lessThan(abs(partitionedResult - subsetResult), f16vec2(gl_SubgroupSize==128 ? 0.2: 0.1))) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      f16vec2 idhashFmt = f16vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      f16vec2 partitionedResult = subgroupPartitionedExclusiveMulNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          f16vec2 iFmt = f16vec2(i);
          if (all(lessThan(abs(idhashFmt - iFmt), f16vec2(gl_SubgroupSize==128 ? 0.2: 0.1)))) {
            f16vec2 subsetResult = subgroupExclusiveMul(data[gl_SubgroupInvocationID]);
            tempResult |= all(lessThan(abs(partitionedResult - subsetResult), f16vec2(gl_SubgroupSize==128 ? 0.2: 0.1))) ? (0x20000 << N) : 0;
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
