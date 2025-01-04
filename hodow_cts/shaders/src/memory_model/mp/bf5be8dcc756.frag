#version 450 core
#pragma use_vulkan_memory_model
#extension GL_EXT_shader_atomic_float : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_shuffle : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_ARB_gpu_shader_int64 : enable
#extension GL_EXT_buffer_reference : enable
// DIM/NUM_WORKGROUP_EACH_DIM overriden by spec constants
layout(constant_id = 0) const int DIM = 1;
layout(constant_id = 1) const int NUM_WORKGROUP_EACH_DIM = 1;
struct S { float x[DIM*DIM]; };
layout(set=0, binding=0, r32f) uniform subgroupcoherent image2D payload;
layout(buffer_reference) buffer GuardRef { float x[]; };
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
   imageStore(payload, imageCoord, vec4(float(bufferCoord + (floatBitsToInt(float(imageLoad(payload, partnerImageCoord).x))>>31)), 0, 0, 0)); 
   atomicExchange(guard.x[bufferCoord], float(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], float(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   float r = imageLoad(payload, partnerImageCoord).x;
   if (!skip && r != float(partnerBufferCoord)) { fail.x[bufferCoord] = 1; }
}
