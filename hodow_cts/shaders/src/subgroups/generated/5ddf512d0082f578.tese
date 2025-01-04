#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  f16vec4 allResult = subgroupPartitionedInclusiveAddNV(data[gl_SubgroupInvocationID], allBallot);
  f16vec4 refResult = subgroupInclusiveAdd(data[gl_SubgroupInvocationID]);
  if (all(lessThan(abs(allResult - refResult), f16vec4(gl_SubgroupSize==128 ? 0.2: 0.1)))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    f16vec4 allResult = subgroupPartitionedInclusiveAddNV(data[gl_SubgroupInvocationID], allBallot);
    f16vec4 refResult = subgroupInclusiveAdd(data[gl_SubgroupInvocationID]);
    if (all(lessThan(abs(allResult - refResult), f16vec4(gl_SubgroupSize==128 ? 0.2: 0.1)))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  f16vec4 selfResult = subgroupPartitionedInclusiveAddNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(lessThan(abs(selfResult - data[gl_SubgroupInvocationID]), f16vec4(gl_SubgroupSize==128 ? 0.2: 0.1)))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    f16vec4 idhashFmt = f16vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    f16vec4 partitionedResult = subgroupPartitionedInclusiveAddNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        f16vec4 iFmt = f16vec4(i);
        if (all(lessThan(abs(idhashFmt - iFmt), f16vec4(gl_SubgroupSize==128 ? 0.2: 0.1)))) {
          f16vec4 subsetResult = subgroupInclusiveAdd(data[gl_SubgroupInvocationID]);
          tempResult |= all(lessThan(abs(partitionedResult - subsetResult), f16vec4(gl_SubgroupSize==128 ? 0.2: 0.1))) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      f16vec4 idhashFmt = f16vec4(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      f16vec4 partitionedResult = subgroupPartitionedInclusiveAddNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          f16vec4 iFmt = f16vec4(i);
          if (all(lessThan(abs(idhashFmt - iFmt), f16vec4(gl_SubgroupSize==128 ? 0.2: 0.1)))) {
            f16vec4 subsetResult = subgroupInclusiveAdd(data[gl_SubgroupInvocationID]);
            tempResult |= all(lessThan(abs(partitionedResult - subsetResult), f16vec4(gl_SubgroupSize==128 ? 0.2: 0.1))) ? (0x20000 << N) : 0;
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
