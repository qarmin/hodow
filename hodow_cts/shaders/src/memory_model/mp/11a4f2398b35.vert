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
layout(set=0, binding=0, r32f) uniform nonprivate image2D payload;
layout(set=0, binding=1) buffer Guard { float x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   float r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], float(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, vec4(float(bufferCoord), 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
