#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_shuffle : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_ARB_gpu_shader_int64 : enable
#extension GL_EXT_buffer_reference : enable
// DIM/NUM_WORKGROUP_EACH_DIM overriden by spec constants
layout(constant_id = 0) const int DIM = 1;
layout(constant_id = 1) const int NUM_WORKGROUP_EACH_DIM = 1;
struct S { uint x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   if (gl_HelperInvocation) { return; }
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId        = ivec2(gl_FragCoord.xy) % ivec2(DIM);
   ivec2 groupId        = ivec2(gl_FragCoord.xy) / ivec2(DIM);
   ivec2 partnerLocalId = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   ivec2 partnerGroupId = subgroupShuffleXor(groupId, gl_SubgroupSize-1);
   uint sharedCoord     = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord     = (groupId.y * NUM_WORKGROUP_EACH_DIM + groupId.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (partnerGroupId.y * NUM_WORKGROUP_EACH_DIM + partnerGroupId.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord     = ivec2(groupId.xy * ivec2(DIM) + localId);
   ivec2 partnerImageCoord = ivec2(partnerGroupId.xy * ivec2(DIM) + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
