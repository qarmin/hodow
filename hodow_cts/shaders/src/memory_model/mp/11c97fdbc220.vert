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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   uint bufferCoord        = gl_VertexIndex;
   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);
   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = imageLoad(payload, partnerImageCoord).x;
   memoryBarrier(gl_ScopeSubgroup, gl_StorageSemanticsImage | gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, 0, 0);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, 0, 0) == 0;
   memoryBarrier(gl_ScopeSubgroup, gl_StorageSemanticsImage | gl_StorageSemanticsBuffer, gl_SemanticsAcquire);
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
