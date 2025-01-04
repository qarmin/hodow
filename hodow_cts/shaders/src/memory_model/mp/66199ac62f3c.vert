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
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   payload.x[bufferCoord] = bufferCoord + (payload.x[partnerBufferCoord]>>31);
   imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease | gl_SemanticsMakeAvailable);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire | gl_SemanticsMakeVisible) == 0;
   uint r = payload.x[partnerBufferCoord];
   if (!skip && r != uint(partnerBufferCoord)) { fail.x[bufferCoord] = 1; }
}
