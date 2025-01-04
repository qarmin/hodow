#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  dvec3 allResult = subgroupPartitionedAddNV(data[gl_SubgroupInvocationID], allBallot);
  dvec3 refResult = subgroupAdd(data[gl_SubgroupInvocationID]);
  if (all(lessThan(abs(allResult - refResult), dvec3(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    dvec3 allResult = subgroupPartitionedAddNV(data[gl_SubgroupInvocationID], allBallot);
    dvec3 refResult = subgroupAdd(data[gl_SubgroupInvocationID]);
    if (all(lessThan(abs(allResult - refResult), dvec3(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  dvec3 selfResult = subgroupPartitionedAddNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(lessThan(abs(selfResult - data[gl_SubgroupInvocationID]), dvec3(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    dvec3 idhashFmt = dvec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    dvec3 partitionedResult = subgroupPartitionedAddNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        dvec3 iFmt = dvec3(i);
        if (all(lessThan(abs(idhashFmt - iFmt), dvec3(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
          dvec3 subsetResult = subgroupAdd(data[gl_SubgroupInvocationID]);
          tempResult |= all(lessThan(abs(partitionedResult - subsetResult), dvec3(gl_SubgroupSize==128 ? 0.000025: 0.00001))) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      dvec3 idhashFmt = dvec3(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      dvec3 partitionedResult = subgroupPartitionedAddNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          dvec3 iFmt = dvec3(i);
          if (all(lessThan(abs(idhashFmt - iFmt), dvec3(gl_SubgroupSize==128 ? 0.000025: 0.00001)))) {
            dvec3 subsetResult = subgroupAdd(data[gl_SubgroupInvocationID]);
            tempResult |= all(lessThan(abs(partitionedResult - subsetResult), dvec3(gl_SubgroupSize==128 ? 0.000025: 0.00001))) ? (0x20000 << N) : 0;
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
