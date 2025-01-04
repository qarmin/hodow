#version 450
#extension GL_NV_shader_subgroup_partitioned: enable
#extension GL_KHR_shader_subgroup_arithmetic: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint tempResult = 0;
  uint id = gl_SubgroupInvocationID;
  uvec4 allBallot = mask;
  vector<uint, 8> allResult = subgroupPartitionedMinNV(data[gl_SubgroupInvocationID], allBallot);
  vector<uint, 8> refResult = subgroupMin(data[gl_SubgroupInvocationID]);
  if (all(equal(allResult, refResult))) {
      tempResult |= 0x1;
  }
  if (0 == (gl_SubgroupInvocationID % 2)) {
    vector<uint, 8> allResult = subgroupPartitionedMinNV(data[gl_SubgroupInvocationID], allBallot);
    vector<uint, 8> refResult = subgroupMin(data[gl_SubgroupInvocationID]);
    if (all(equal(allResult, refResult))) {
        tempResult |= 0x2;
    }
  } else {
    tempResult |= 0x2;
  }
  uvec4 selfBallot = subgroupPartitionNV(gl_SubgroupInvocationID);
  vector<uint, 8> selfResult = subgroupPartitionedMinNV(data[gl_SubgroupInvocationID], selfBallot);
  if (all(equal(selfResult, data[gl_SubgroupInvocationID]))) {
      tempResult |= 0x4;
  }
  for (uint N = 1; N < 16; ++N) {
    vector<uint, 8> idhashFmt = vector<uint, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
    uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
    vector<uint, 8> partitionedResult = subgroupPartitionedMinNV(data[gl_SubgroupInvocationID], partitionBallot);
      for (uint i = 0; i < N; ++i) {
        vector<uint, 8> iFmt = vector<uint, 8>(i);
        if (all(equal(idhashFmt, iFmt))) {
          vector<uint, 8> subsetResult = subgroupMin(data[gl_SubgroupInvocationID]);
          tempResult |= all(equal(partitionedResult, subsetResult)) ? (0x4 << N) : 0;
        }
      }
  }
  if (1 == (gl_SubgroupInvocationID % 2)) {
    for (uint N = 1; N < 7; ++N) {
      vector<uint, 8> idhashFmt = vector<uint, 8>(((id%N)+(id%(N+1))-(id%2)+(id/2))%((N+1)/2));
      uvec4 partitionBallot = subgroupPartitionNV(idhashFmt) & mask;
      vector<uint, 8> partitionedResult = subgroupPartitionedMinNV(data[gl_SubgroupInvocationID], partitionBallot);
        for (uint i = 0; i < N; ++i) {
          vector<uint, 8> iFmt = vector<uint, 8>(i);
          if (all(equal(idhashFmt, iFmt))) {
            vector<uint, 8> subsetResult = subgroupMin(data[gl_SubgroupInvocationID]);
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
  gl_PointSize = gl_in[0].gl_PointSize;
}
