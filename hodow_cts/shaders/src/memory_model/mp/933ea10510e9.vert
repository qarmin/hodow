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
layout(buffer_reference) buffer PayloadRef { float x[]; };
layout(buffer_reference) buffer GuardRef { float x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   subgroupcoherent PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   uint bufferCoord        = gl_VertexIndex;
   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);
   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   payload.x[bufferCoord] = float(bufferCoord) + ((floatBitsToInt(float(payload.x[partnerBufferCoord])))>>31);
   atomicExchange(guard.x[bufferCoord], float(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], float(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   float r = payload.x[partnerBufferCoord];
   if (!skip && r != float(partnerBufferCoord)) { fail.x[bufferCoord] = 1; }
}
