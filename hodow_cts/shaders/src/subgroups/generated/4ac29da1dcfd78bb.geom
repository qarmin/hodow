#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  i64vec2 allResult = subgroupPartitionedExclusiveAndNV(data[gl_SubgroupInvocationID], allBallot);
  i64vec2 refResult = subgroupExclusiveAnd(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    i64vec2 allResult = subgroupPartitionedExclusiveAndNV(data[gl_SubgroupInvocationID], allBallot);
    i64vec2 refResult = subgroupExclusiveAnd(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  i64vec2 selfResult = subgroupPartitionedExclusiveAndNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, i64vec2(~0)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    i64vec2 idhashFmt = i64vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    i64vec2 partitionedResult = subgroupPartitionedExclusiveAndNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        i64vec2 iFmt = i64vec2(i);
        if (all(equal(idhashFmt, iFmt))) {
          i64vec2 subsetResult = subgroupExclusiveAnd(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      i64vec2 idhashFmt = i64vec2(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      i64vec2 partitionedResult = subgroupPartitionedExclusiveAndNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          i64vec2 iFmt = i64vec2(i);
          if (all(equal(idhashFmt, iFmt))) {
            i64vec2 subsetResult = subgroupExclusiveAnd(data[gl_SubgroupInvocationID]);
            tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x20000 << N) : 0;
          }
        }
    }
  } else {
    tempResult |= 0xFC0000;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
