#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  float16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  float16_t allResult = subgroupPartitionedExclusiveMulNV(data[gl_SubgroupInvocationID], allBallot);
  float16_t refResult = subgroupExclusiveMul(data[gl_SubgroupInvocationID]);
  if ((abs(allResult - refResult) < float16_t(gl_SubgroupSize==128 ? 0.2: 0.1))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    float16_t allResult = subgroupPartitionedExclusiveMulNV(data[gl_SubgroupInvocationID], allBallot);
    float16_t refResult = subgroupExclusiveMul(data[gl_SubgroupInvocationID]);
    if ((abs(allResult - refResult) < float16_t(gl_SubgroupSize==128 ? 0.2: 0.1))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  float16_t selfResult = subgroupPartitionedExclusiveMulNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((abs(selfResult - float16_t(1)) < float16_t(gl_SubgroupSize==128 ? 0.2: 0.1))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    float16_t idhashFmt = float16_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    float16_t partitionedResult = subgroupPartitionedExclusiveMulNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        float16_t iFmt = float16_t(i);
        if ((abs(idhashFmt - iFmt) < float16_t(gl_SubgroupSize==128 ? 0.2: 0.1))) {
          float16_t subsetResult = subgroupExclusiveMul(data[gl_SubgroupInvocationID]);
          tempResult |= (abs(partitionedResult - subsetResult) < float16_t(gl_SubgroupSize==128 ? 0.2: 0.1)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      float16_t idhashFmt = float16_t(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      float16_t partitionedResult = subgroupPartitionedExclusiveMulNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          float16_t iFmt = float16_t(i);
          if ((abs(idhashFmt - iFmt) < float16_t(gl_SubgroupSize==128 ? 0.2: 0.1))) {
            float16_t subsetResult = subgroupExclusiveMul(data[gl_SubgroupInvocationID]);
            tempResult |= (abs(partitionedResult - subsetResult) < float16_t(gl_SubgroupSize==128 ? 0.2: 0.1)) ? (0x20000 << N) : 0;
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
