#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_ARB_gpu_shader_int64: enable
#extension GL_KHR_shader_subgroup_basic: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint data[];
};

shared uvec4 superSecretComputeShaderHelper[gl_WorkGroupSize.x * gl_WorkGroupSize.y * gl_WorkGroupSize.z];
uint64_t sharedMemoryBallot(bool vote)
{
  uint groupOffset = gl_SubgroupID;
  // One invocation in the group 0's the whole group's data
  if (subgroupElect())
  {
    superSecretComputeShaderHelper[groupOffset] = uvec4(0);
  }
  subgroupMemoryBarrierShared();
  if (vote)
  {
    const highp uint invocationId = gl_SubgroupInvocationID % 32;
    const highp uint bitToSet = 1u << invocationId;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: atomicOr(superSecretComputeShaderHelper[groupOffset].x, bitToSet); break;
    case 1: atomicOr(superSecretComputeShaderHelper[groupOffset].y, bitToSet); break;
    case 2: atomicOr(superSecretComputeShaderHelper[groupOffset].z, bitToSet); break;
    case 3: atomicOr(superSecretComputeShaderHelper[groupOffset].w, bitToSet); break;
    }
  }
  subgroupMemoryBarrierShared();
  return packUint2x32(superSecretComputeShaderHelper[groupOffset].xy);
}
void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  uint tempResult = 0;
  tempResult |= sharedMemoryBallot(true) == ballotARB(true) ? 0x1 : 0;
  bool bData = data[gl_SubgroupInvocationID] != 0;
  tempResult |= sharedMemoryBallot(bData) == ballotARB(bData) ? 0x2 : 0;
  tempResult |= uint64_t(0) == ballotARB(false) ? 0x4 : 0;
  tempRes = tempResult;
  result[offset] = tempRes;
}
