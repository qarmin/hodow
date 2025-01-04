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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[sharedCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[sharedCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
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
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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

   uint r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
#version 450 core
vec2 coords[4] = {ivec2(-1,-1), ivec2(-1, 1), ivec2(1, -1), ivec2(1, 1)};
void main() { gl_Position = vec4(coords[gl_VertexIndex], 0, 1); }
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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
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
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
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

   uint r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
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
   imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
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
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   uint bufferCoord        = gl_VertexIndex;
   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);
   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = imageLoad(payload, partnerImageCoord).x;
   imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   uint bufferCoord        = gl_VertexIndex;
   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);
   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = imageLoad(payload, partnerImageCoord).x;
   imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uint r = imageLoad(payload, partnerImageCoord).x;
   imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[sharedCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = payload.x[partnerSharedCoord];
   imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[sharedCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   uint bufferCoord        = gl_VertexIndex;
   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);
   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
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
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
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
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   uint bufferCoord        = gl_VertexIndex;
   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);
   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   uint bufferCoord        = gl_VertexIndex;
   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);
   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
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
   atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
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

   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
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
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
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

   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
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
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = imageLoad(payload, partnerImageCoord).x;
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = imageLoad(payload, partnerImageCoord).x;
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
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

   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
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
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
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
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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

   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
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

   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
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
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
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

   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
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
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
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

   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
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
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = imageLoad(payload, partnerImageCoord).x;
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = imageLoad(payload, partnerImageCoord).x;
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
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

   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
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
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
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
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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

   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
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

   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
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
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
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
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = imageLoad(payload, partnerImageCoord).x;
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
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
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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

   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
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

   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
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
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
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
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   uint bufferCoord        = gl_VertexIndex;
   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);
   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = imageLoad(payload, partnerImageCoord).x;
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   uint bufferCoord        = gl_VertexIndex;
   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);
   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = imageLoad(payload, partnerImageCoord).x;
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uint r = imageLoad(payload, partnerImageCoord).x;
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uint r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = payload.x[partnerSharedCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   uint bufferCoord        = gl_VertexIndex;
   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);
   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(set=0, binding=1) buffer Guard { uint x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
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
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   uint bufferCoord        = gl_VertexIndex;
   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);
   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
   imageAtomicExchange(guard, imageCoord, uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   uint bufferCoord        = gl_VertexIndex;
   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);
   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(buffer_reference) buffer GuardRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsBuffer | gl_StorageSemanticsBuffer, gl_SemanticsAcquireRelease);
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = imageLoad(payload, partnerImageCoord).x;
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsImage | gl_StorageSemanticsImage, gl_SemanticsAcquireRelease);
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared | gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsBuffer | gl_StorageSemanticsBuffer, gl_SemanticsAcquireRelease);
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsBuffer | gl_StorageSemanticsBuffer, gl_SemanticsAcquireRelease);
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = imageLoad(payload, partnerImageCoord).x;
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsImage | gl_StorageSemanticsImage, gl_SemanticsAcquireRelease);
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = payload.x[partnerSharedCoord];
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared | gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsBuffer | gl_StorageSemanticsBuffer, gl_SemanticsAcquireRelease);
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   memoryBarrier(gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeInvocation, 0, 0);
   memoryBarrier(gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire);
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = imageLoad(payload, partnerImageCoord).x;
   memoryBarrier(gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeInvocation, 0, 0);
   memoryBarrier(gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire);
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint r = payload.x[partnerSharedCoord];
   memoryBarrier(gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeInvocation, 0, 0);
   memoryBarrier(gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire);
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   memoryBarrier(gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeInvocation, 0, 0);
   memoryBarrier(gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire);
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint x[]; } payload;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   memoryBarrier(gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeInvocation, 0, 0);
   memoryBarrier(gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire);
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = imageLoad(payload, partnerImageCoord).x;
   memoryBarrier(gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeInvocation, 0, 0);
   memoryBarrier(gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire);
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint r = payload.x[partnerSharedCoord];
   memoryBarrier(gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeInvocation, 0, 0);
   memoryBarrier(gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire);
   if (!skip) {
      payload.x[sharedCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint r = payload.x[partnerBufferCoord];
   memoryBarrier(gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeInvocation, 0, 0);
   memoryBarrier(gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire);
   if (!skip) {
      payload.x[bufferCoord] = uint(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform devicecoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform devicecoherent uimage2D guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform devicecoherent uimage2D guard;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform devicecoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform devicecoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform devicecoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform devicecoherent uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform devicecoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform devicecoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform devicecoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform devicecoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform devicecoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform devicecoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform devicecoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform queuefamilycoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform queuefamilycoherent uimage2D guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform queuefamilycoherent uimage2D guard;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform queuefamilycoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform queuefamilycoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform queuefamilycoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform queuefamilycoherent uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform queuefamilycoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform queuefamilycoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform queuefamilycoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform queuefamilycoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform queuefamilycoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform queuefamilycoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform queuefamilycoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) workgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) workgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform workgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) workgroupcoherent buffer Payload { uint64_t x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) workgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform workgroupcoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform workgroupcoherent uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform workgroupcoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform workgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   workgroupcoherent PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform workgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   workgroupcoherent PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   workgroupcoherent PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   workgroupcoherent PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform subgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform subgroupcoherent uimage2D guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform subgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform subgroupcoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform subgroupcoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform subgroupcoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform subgroupcoherent uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform subgroupcoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform subgroupcoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform subgroupcoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform subgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerSharedCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   subgroupcoherent PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   subgroupcoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform subgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   subgroupcoherent PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform subgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
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

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform subgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   subgroupcoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   subgroupcoherent PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
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
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform devicecoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform devicecoherent uimage2D guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform devicecoherent uimage2D guard;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) devicecoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform devicecoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform devicecoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform devicecoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform devicecoherent uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform devicecoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform devicecoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform devicecoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform devicecoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform devicecoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform devicecoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform devicecoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   devicecoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform queuefamilycoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform queuefamilycoherent uimage2D guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform queuefamilycoherent uimage2D guard;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) queuefamilycoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform queuefamilycoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform queuefamilycoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform queuefamilycoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform queuefamilycoherent uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform queuefamilycoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform queuefamilycoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform queuefamilycoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform queuefamilycoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform queuefamilycoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform queuefamilycoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform queuefamilycoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   queuefamilycoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) workgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) workgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform workgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) workgroupcoherent buffer Payload { uint64_t x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) workgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform workgroupcoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform workgroupcoherent uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform workgroupcoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform workgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   workgroupcoherent PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform workgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   workgroupcoherent PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   workgroupcoherent PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   workgroupcoherent PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform subgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform subgroupcoherent uimage2D guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform subgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) subgroupcoherent buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform subgroupcoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform subgroupcoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform subgroupcoherent uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform subgroupcoherent uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform subgroupcoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform subgroupcoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform subgroupcoherent uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform subgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerSharedCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerSharedCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   subgroupcoherent PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   subgroupcoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform subgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   subgroupcoherent PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform subgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
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

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1, r32ui) uniform subgroupcoherent uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   subgroupcoherent PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicExchange(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicExchange(guard, partnerImageCoord, (2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   subgroupcoherent PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[sharedCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerSharedCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
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
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicExchange(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicExchange(guard.x[partnerBufferCoord], uint64_t(2u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeDevice, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
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
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
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

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeDevice, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
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
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
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

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);
   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);
   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;
   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;
   ivec2 imageCoord        = globalId;
   ivec2 partnerImageCoord = partnerGlobalId;
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeQueueFamily, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerSharedCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
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
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   barrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeWorkgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
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

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0) nonprivate buffer Payload { uint64_t x[]; } payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
layout(offset = 8) GuardRef guard;
};
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

   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(set=0, binding=0, r32ui) uniform nonprivate uimage2D payload;
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
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
   uint64_t r = imageLoad(payload, partnerImageCoord).x;
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsImage, gl_SemanticsAcquire) == 0;
   if (!skip) {
      imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
shared S payload;
layout(set=0, binding=1, r32ui) uniform nonprivate uimage2D guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
void main()
{
   bool pass = true;
   bool skip = false;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   payload.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerSharedCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[sharedCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   uint bufferCoord        = gl_VertexIndex;
   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);
   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(set=0, binding=1) buffer Guard { uint64_t x[]; } guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
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
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
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
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
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
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   uint bufferCoord        = gl_VertexIndex;
   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);
   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));
   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);
   gl_PointSize            = 1.0f;
   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);

   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
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
   uint64_t r = payload.x[partnerBufferCoord];
   imageAtomicStore(guard, imageCoord, (1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = imageAtomicLoad(guard, partnerImageCoord, gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
shared S guard;
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   guard.x[sharedCoord] = 0;
   subgroupBarrier();
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[sharedCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerSharedCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
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
struct S { uint64_t x[DIM*DIM]; };
layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;
layout(buffer_reference) buffer PayloadRef { uint64_t x[]; };
layout(buffer_reference) buffer GuardRef { uint64_t x[]; };
layout(set=0, binding=2) buffer Fail { uint x[]; } fail;
layout (push_constant, std430) uniform PC {
   layout(offset = 0) PayloadRef payloadref;
layout(offset = 8) GuardRef guard;
};
void main()
{
   bool pass = true;
   bool skip = false;
   nonprivate PayloadRef payload = payloadref;
   uvec4 ballot = subgroupBallot(true);
   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }
   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);
   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);
   uint sharedCoord        = localId.y * DIM + localId.x;
   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;
   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;
   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;
   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);
   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);
   uint64_t r = payload.x[partnerBufferCoord];
   atomicStore(guard.x[bufferCoord], uint64_t(1u), gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsRelease);
   skip = atomicLoad(guard.x[partnerBufferCoord], gl_ScopeSubgroup, gl_StorageSemanticsBuffer, gl_SemanticsAcquire) == 0;
   if (!skip) {
      payload.x[bufferCoord] = uint64_t(bufferCoord);
   }
   if (r != 0) { fail.x[bufferCoord] = 1; }
}
