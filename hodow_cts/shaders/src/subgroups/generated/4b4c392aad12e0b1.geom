#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  float allResult = subgroupPartitionedInclusiveAddNV(data[gl_SubgroupInvocationID], allBallot);
  float refResult = subgroupInclusiveAdd(data[gl_SubgroupInvocationID]);
  if ((abs(allResult - refResult) < (gl_SubgroupSize==128 ? 0.000025:0.00001))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    float allResult = subgroupPartitionedInclusiveAddNV(data[gl_SubgroupInvocationID], allBallot);
    float refResult = subgroupInclusiveAdd(data[gl_SubgroupInvocationID]);
    if ((abs(allResult - refResult) < (gl_SubgroupSize==128 ? 0.000025:0.00001))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  float selfResult = subgroupPartitionedInclusiveAddNV(data[gl_SubgroupInvocationID], selfBallot);
  if ((abs(selfResult - data[gl_SubgroupInvocationID]) < (gl_SubgroupSize==128 ? 0.000025:0.00001))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    float idhashFmt = float(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    float partitionedResult = subgroupPartitionedInclusiveAddNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        float iFmt = float(i);
        if ((abs(idhashFmt - iFmt) < (gl_SubgroupSize==128 ? 0.000025:0.00001))) {
          float subsetResult = subgroupInclusiveAdd(data[gl_SubgroupInvocationID]);
          tempResult |= (abs(partitionedResult - subsetResult) < (gl_SubgroupSize==128 ? 0.000025:0.00001)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      float idhashFmt = float(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      float partitionedResult = subgroupPartitionedInclusiveAddNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          float iFmt = float(i);
          if ((abs(idhashFmt - iFmt) < (gl_SubgroupSize==128 ? 0.000025:0.00001))) {
            float subsetResult = subgroupInclusiveAdd(data[gl_SubgroupInvocationID]);
            tempResult |= (abs(partitionedResult - subsetResult) < (gl_SubgroupSize==128 ? 0.000025:0.00001)) ? (0x20000 << N) : 0;
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
