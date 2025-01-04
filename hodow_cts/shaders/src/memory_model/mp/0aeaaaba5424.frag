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
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
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
   uint r = imageLoad(payload, partnerImageCoord).x;
   imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, 0, 0) == 0;
   memoryBarrier(gl_ScopeQueueFamily, gl_StorageSemanticsImage | gl_StorageSemanticsImage, gl_SemanticsAcquire);
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
