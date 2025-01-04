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
struct S { double x[DIM*DIM]; };
layout(set=0, binding=0) devicecoherent buffer Payload { double x[]; } payload;
layout(set=0, binding=1) buffer Guard { double x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   if (gl_HelperInvocation) { return; }
   ivec2 localId       = ivec2(gl_FragCoord.xy) % ivec2(DIM);
   ivec2 groupId       = ivec2(gl_FragCoord.xy) / ivec2(DIM);
   ivec2 partnerLocalId = ivec2(DIM-1)-localId;
   ivec2 partnerGroupId = groupId;
   uint sharedCoord    = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord    = (groupId.y * NUM_WORKGROUP_EACH_DIM + groupId.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (partnerGroupId.y * NUM_WORKGROUP_EACH_DIM + partnerGroupId.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord    = ivec2(groupId.xy * ivec2(DIM) + localId);
   ivec2 partnerImageCoord = ivec2(partnerGroupId.xy * ivec2(DIM) + partnerLocalId);
   payload.x[bufferCoord] = double(bufferCoord) + ((floatBitsToInt(float(payload.x[partnerBufferCoord])))>>31);
   atomicExchange(guard.x[bufferCoord], double(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], double(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   double r = payload.x[partnerBufferCoord];
   if (!skip && r != double(partnerBufferCoord)) { fail.x[bufferCoord] = 1; }
}
