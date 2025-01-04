#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform image1D u_image0;
layout (binding = 1, rgba32f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba32f) readonly uniform image1D u_image0;
layout (binding = 0, rgba32f) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
vec4 positions[6] = vec4[](
    vec4(-1.0f, -1.0f, 1.0f, 1.0f),
    vec4( 1.0f, -1.0f, 1.0f, 1.0f),
    vec4(-1.0f,  1.0f, 1.0f, 1.0f),
    vec4(-1.0f,  1.0f, 1.0f, 1.0f),
    vec4( 1.0f, -1.0f, 1.0f, 1.0f),
    vec4( 1.0f,  1.0f, 1.0f, 1.0f)
);

void main() {
    gl_Position = positions[gl_VertexIndex];
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba32f) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) readonly uniform image1D u_image0;
layout (binding = 1, rgba16f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16f) readonly uniform image1D u_image0;
layout (binding = 0, rgba16f) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba16f) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) readonly uniform image1D u_image0;
layout (binding = 1, r32f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r32f) readonly uniform image1D u_image0;
layout (binding = 0, r32f) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r32f) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba32ui) readonly uniform uimage1D u_image0;
layout (binding = 0, rgba32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba32ui) readonly uniform uimage1D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16ui) readonly uniform uimage1D u_image0;
layout (binding = 0, rgba16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba16ui) readonly uniform uimage1D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba8ui) readonly uniform uimage1D u_image0;
layout (binding = 0, rgba8ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba8ui) readonly uniform uimage1D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) readonly uniform uimage1D u_image0;
layout (binding = 1, r32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r32ui) readonly uniform uimage1D u_image0;
layout (binding = 0, r32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r32ui) readonly uniform uimage1D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) readonly uniform iimage1D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba32i) readonly uniform iimage1D u_image0;
layout (binding = 0, rgba32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba32i) readonly uniform iimage1D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) readonly uniform iimage1D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16i) readonly uniform iimage1D u_image0;
layout (binding = 0, rgba16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba16i) readonly uniform iimage1D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) readonly uniform iimage1D u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba8i) readonly uniform iimage1D u_image0;
layout (binding = 0, rgba8i) writeonly uniform iimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba8i) readonly uniform iimage1D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) readonly uniform iimage1D u_image0;
layout (binding = 1, r32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r32i) readonly uniform iimage1D u_image0;
layout (binding = 0, r32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r32i) readonly uniform iimage1D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) readonly uniform image1D u_image0;
layout (binding = 1, rgba8) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba8) readonly uniform image1D u_image0;
layout (binding = 0, rgba8) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba8) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) readonly uniform image1D u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba8_snorm) readonly uniform image1D u_image0;
layout (binding = 0, rgba8_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba8_snorm) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) readonly uniform image1D u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r11f_g11f_b10f) readonly uniform image1D u_image0;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r11f_g11f_b10f) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) readonly uniform image1D u_image0;
layout (binding = 1, rg32f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg32f) readonly uniform image1D u_image0;
layout (binding = 0, rg32f) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg32f) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) readonly uniform image1D u_image0;
layout (binding = 1, rg16f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16f) readonly uniform image1D u_image0;
layout (binding = 0, rg16f) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg16f) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) readonly uniform image1D u_image0;
layout (binding = 1, r16f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16f) readonly uniform image1D u_image0;
layout (binding = 0, r16f) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r16f) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgb10_a2ui) readonly uniform uimage1D u_image0;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgb10_a2ui) readonly uniform uimage1D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg32ui) readonly uniform uimage1D u_image0;
layout (binding = 0, rg32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg32ui) readonly uniform uimage1D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16ui) readonly uniform uimage1D u_image0;
layout (binding = 0, rg16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg16ui) readonly uniform uimage1D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) readonly uniform uimage1D u_image0;
layout (binding = 1, r16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16ui) readonly uniform uimage1D u_image0;
layout (binding = 0, r16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r16ui) readonly uniform uimage1D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg8ui) readonly uniform uimage1D u_image0;
layout (binding = 0, rg8ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg8ui) readonly uniform uimage1D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) readonly uniform uimage1D u_image0;
layout (binding = 1, r8ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r8ui) readonly uniform uimage1D u_image0;
layout (binding = 0, r8ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r8ui) readonly uniform uimage1D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) readonly uniform iimage1D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg32i) readonly uniform iimage1D u_image0;
layout (binding = 0, rg32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg32i) readonly uniform iimage1D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) readonly uniform iimage1D u_image0;
layout (binding = 1, rg16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16i) readonly uniform iimage1D u_image0;
layout (binding = 0, rg16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg16i) readonly uniform iimage1D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) readonly uniform iimage1D u_image0;
layout (binding = 1, r16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16i) readonly uniform iimage1D u_image0;
layout (binding = 0, r16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r16i) readonly uniform iimage1D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) readonly uniform iimage1D u_image0;
layout (binding = 1, rg8i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg8i) readonly uniform iimage1D u_image0;
layout (binding = 0, rg8i) writeonly uniform iimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg8i) readonly uniform iimage1D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) readonly uniform iimage1D u_image0;
layout (binding = 1, r8i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r8i) readonly uniform iimage1D u_image0;
layout (binding = 0, r8i) writeonly uniform iimage1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r8i) readonly uniform iimage1D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) readonly uniform image1D u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgb10_a2) readonly uniform image1D u_image0;
layout (binding = 0, rgb10_a2) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgb10_a2) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) readonly uniform image1D u_image0;
layout (binding = 1, rgba16) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16) readonly uniform image1D u_image0;
layout (binding = 0, rgba16) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba16) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) readonly uniform image1D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16_snorm) readonly uniform image1D u_image0;
layout (binding = 0, rgba16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba16_snorm) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) readonly uniform image1D u_image0;
layout (binding = 1, rg16) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16) readonly uniform image1D u_image0;
layout (binding = 0, rg16) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg16) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) readonly uniform image1D u_image0;
layout (binding = 1, r16) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16) readonly uniform image1D u_image0;
layout (binding = 0, r16) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r16) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) readonly uniform image1D u_image0;
layout (binding = 1, rg8) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg8) readonly uniform image1D u_image0;
layout (binding = 0, rg8) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg8) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) readonly uniform image1D u_image0;
layout (binding = 1, r8) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r8) readonly uniform image1D u_image0;
layout (binding = 0, r8) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r8) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) readonly uniform image1D u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16_snorm) readonly uniform image1D u_image0;
layout (binding = 0, rg16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg16_snorm) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) readonly uniform image1D u_image0;
layout (binding = 1, r16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16_snorm) readonly uniform image1D u_image0;
layout (binding = 0, r16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r16_snorm) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) readonly uniform image1D u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg8_snorm) readonly uniform image1D u_image0;
layout (binding = 0, rg8_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg8_snorm) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) readonly uniform image1D u_image0;
layout (binding = 1, r8_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r8_snorm) readonly uniform image1D u_image0;
layout (binding = 0, r8_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r8_snorm) readonly uniform image1D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    int pos = int(gl_FragCoord.x);
    outcolor = imageLoad(u_image0, pos);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform image2D u_image0;
layout (binding = 1, rgba32f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba32f) readonly uniform image2D u_image0;
layout (binding = 0, rgba32f) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba32f) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) readonly uniform image2D u_image0;
layout (binding = 1, rgba16f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16f) readonly uniform image2D u_image0;
layout (binding = 0, rgba16f) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba16f) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) readonly uniform image2D u_image0;
layout (binding = 1, r32f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r32f) readonly uniform image2D u_image0;
layout (binding = 0, r32f) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r32f) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba32ui) readonly uniform uimage2D u_image0;
layout (binding = 0, rgba32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba32ui) readonly uniform uimage2D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16ui) readonly uniform uimage2D u_image0;
layout (binding = 0, rgba16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba16ui) readonly uniform uimage2D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba8ui) readonly uniform uimage2D u_image0;
layout (binding = 0, rgba8ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba8ui) readonly uniform uimage2D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) readonly uniform uimage2D u_image0;
layout (binding = 1, r32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r32ui) readonly uniform uimage2D u_image0;
layout (binding = 0, r32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r32ui) readonly uniform uimage2D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) readonly uniform iimage2D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba32i) readonly uniform iimage2D u_image0;
layout (binding = 0, rgba32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba32i) readonly uniform iimage2D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) readonly uniform iimage2D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16i) readonly uniform iimage2D u_image0;
layout (binding = 0, rgba16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba16i) readonly uniform iimage2D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) readonly uniform iimage2D u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba8i) readonly uniform iimage2D u_image0;
layout (binding = 0, rgba8i) writeonly uniform iimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba8i) readonly uniform iimage2D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) readonly uniform iimage2D u_image0;
layout (binding = 1, r32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r32i) readonly uniform iimage2D u_image0;
layout (binding = 0, r32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r32i) readonly uniform iimage2D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) readonly uniform image2D u_image0;
layout (binding = 1, rgba8) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba8) readonly uniform image2D u_image0;
layout (binding = 0, rgba8) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba8) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) readonly uniform image2D u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba8_snorm) readonly uniform image2D u_image0;
layout (binding = 0, rgba8_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba8_snorm) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) readonly uniform image2D u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r11f_g11f_b10f) readonly uniform image2D u_image0;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r11f_g11f_b10f) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) readonly uniform image2D u_image0;
layout (binding = 1, rg32f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg32f) readonly uniform image2D u_image0;
layout (binding = 0, rg32f) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg32f) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) readonly uniform image2D u_image0;
layout (binding = 1, rg16f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16f) readonly uniform image2D u_image0;
layout (binding = 0, rg16f) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg16f) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) readonly uniform image2D u_image0;
layout (binding = 1, r16f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16f) readonly uniform image2D u_image0;
layout (binding = 0, r16f) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r16f) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgb10_a2ui) readonly uniform uimage2D u_image0;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgb10_a2ui) readonly uniform uimage2D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg32ui) readonly uniform uimage2D u_image0;
layout (binding = 0, rg32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg32ui) readonly uniform uimage2D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16ui) readonly uniform uimage2D u_image0;
layout (binding = 0, rg16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg16ui) readonly uniform uimage2D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) readonly uniform uimage2D u_image0;
layout (binding = 1, r16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16ui) readonly uniform uimage2D u_image0;
layout (binding = 0, r16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r16ui) readonly uniform uimage2D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg8ui) readonly uniform uimage2D u_image0;
layout (binding = 0, rg8ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg8ui) readonly uniform uimage2D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) readonly uniform uimage2D u_image0;
layout (binding = 1, r8ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r8ui) readonly uniform uimage2D u_image0;
layout (binding = 0, r8ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r8ui) readonly uniform uimage2D u_image0;
layout (location=0) out uvec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) readonly uniform iimage2D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg32i) readonly uniform iimage2D u_image0;
layout (binding = 0, rg32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg32i) readonly uniform iimage2D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) readonly uniform iimage2D u_image0;
layout (binding = 1, rg16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16i) readonly uniform iimage2D u_image0;
layout (binding = 0, rg16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg16i) readonly uniform iimage2D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) readonly uniform iimage2D u_image0;
layout (binding = 1, r16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16i) readonly uniform iimage2D u_image0;
layout (binding = 0, r16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r16i) readonly uniform iimage2D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) readonly uniform iimage2D u_image0;
layout (binding = 1, rg8i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg8i) readonly uniform iimage2D u_image0;
layout (binding = 0, rg8i) writeonly uniform iimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg8i) readonly uniform iimage2D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) readonly uniform iimage2D u_image0;
layout (binding = 1, r8i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r8i) readonly uniform iimage2D u_image0;
layout (binding = 0, r8i) writeonly uniform iimage2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r8i) readonly uniform iimage2D u_image0;
layout (location=0) out ivec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) readonly uniform image2D u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgb10_a2) readonly uniform image2D u_image0;
layout (binding = 0, rgb10_a2) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgb10_a2) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) readonly uniform image2D u_image0;
layout (binding = 1, rgba16) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16) readonly uniform image2D u_image0;
layout (binding = 0, rgba16) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba16) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) readonly uniform image2D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16_snorm) readonly uniform image2D u_image0;
layout (binding = 0, rgba16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rgba16_snorm) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) readonly uniform image2D u_image0;
layout (binding = 1, rg16) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16) readonly uniform image2D u_image0;
layout (binding = 0, rg16) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg16) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) readonly uniform image2D u_image0;
layout (binding = 1, r16) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16) readonly uniform image2D u_image0;
layout (binding = 0, r16) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r16) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) readonly uniform image2D u_image0;
layout (binding = 1, rg8) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg8) readonly uniform image2D u_image0;
layout (binding = 0, rg8) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg8) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) readonly uniform image2D u_image0;
layout (binding = 1, r8) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r8) readonly uniform image2D u_image0;
layout (binding = 0, r8) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r8) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) readonly uniform image2D u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16_snorm) readonly uniform image2D u_image0;
layout (binding = 0, rg16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg16_snorm) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) readonly uniform image2D u_image0;
layout (binding = 1, r16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16_snorm) readonly uniform image2D u_image0;
layout (binding = 0, r16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r16_snorm) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) readonly uniform image2D u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg8_snorm) readonly uniform image2D u_image0;
layout (binding = 0, rg8_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, rg8_snorm) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) readonly uniform image2D u_image0;
layout (binding = 1, r8_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r8_snorm) readonly uniform image2D u_image0;
layout (binding = 0, r8_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(pos.x, pos.y)));
}
#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, r8_snorm) readonly uniform image2D u_image0;
layout (location=0) out vec4 outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec2 pos = ivec2(gl_FragCoord.xy);
    outcolor = imageLoad(u_image0, ivec2(pos.x, pos.y));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform image3D u_image0;
layout (binding = 1, rgba32f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba32f) readonly uniform image3D u_image0;
layout (binding = 0, rgba32f) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) readonly uniform image3D u_image0;
layout (binding = 1, rgba16f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16f) readonly uniform image3D u_image0;
layout (binding = 0, rgba16f) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) readonly uniform image3D u_image0;
layout (binding = 1, r32f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r32f) readonly uniform image3D u_image0;
layout (binding = 0, r32f) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba32ui) readonly uniform uimage3D u_image0;
layout (binding = 0, rgba32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16ui) readonly uniform uimage3D u_image0;
layout (binding = 0, rgba16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba8ui) readonly uniform uimage3D u_image0;
layout (binding = 0, rgba8ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) readonly uniform uimage3D u_image0;
layout (binding = 1, r32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r32ui) readonly uniform uimage3D u_image0;
layout (binding = 0, r32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) readonly uniform iimage3D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba32i) readonly uniform iimage3D u_image0;
layout (binding = 0, rgba32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) readonly uniform iimage3D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16i) readonly uniform iimage3D u_image0;
layout (binding = 0, rgba16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) readonly uniform iimage3D u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba8i) readonly uniform iimage3D u_image0;
layout (binding = 0, rgba8i) writeonly uniform iimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) readonly uniform iimage3D u_image0;
layout (binding = 1, r32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r32i) readonly uniform iimage3D u_image0;
layout (binding = 0, r32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) readonly uniform image3D u_image0;
layout (binding = 1, rgba8) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba8) readonly uniform image3D u_image0;
layout (binding = 0, rgba8) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) readonly uniform image3D u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba8_snorm) readonly uniform image3D u_image0;
layout (binding = 0, rgba8_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) readonly uniform image3D u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r11f_g11f_b10f) readonly uniform image3D u_image0;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) readonly uniform image3D u_image0;
layout (binding = 1, rg32f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg32f) readonly uniform image3D u_image0;
layout (binding = 0, rg32f) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) readonly uniform image3D u_image0;
layout (binding = 1, rg16f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16f) readonly uniform image3D u_image0;
layout (binding = 0, rg16f) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) readonly uniform image3D u_image0;
layout (binding = 1, r16f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16f) readonly uniform image3D u_image0;
layout (binding = 0, r16f) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgb10_a2ui) readonly uniform uimage3D u_image0;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg32ui) readonly uniform uimage3D u_image0;
layout (binding = 0, rg32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16ui) readonly uniform uimage3D u_image0;
layout (binding = 0, rg16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) readonly uniform uimage3D u_image0;
layout (binding = 1, r16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16ui) readonly uniform uimage3D u_image0;
layout (binding = 0, r16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg8ui) readonly uniform uimage3D u_image0;
layout (binding = 0, rg8ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) readonly uniform uimage3D u_image0;
layout (binding = 1, r8ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r8ui) readonly uniform uimage3D u_image0;
layout (binding = 0, r8ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) readonly uniform iimage3D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg32i) readonly uniform iimage3D u_image0;
layout (binding = 0, rg32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) readonly uniform iimage3D u_image0;
layout (binding = 1, rg16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16i) readonly uniform iimage3D u_image0;
layout (binding = 0, rg16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) readonly uniform iimage3D u_image0;
layout (binding = 1, r16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16i) readonly uniform iimage3D u_image0;
layout (binding = 0, r16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) readonly uniform iimage3D u_image0;
layout (binding = 1, rg8i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg8i) readonly uniform iimage3D u_image0;
layout (binding = 0, rg8i) writeonly uniform iimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) readonly uniform iimage3D u_image0;
layout (binding = 1, r8i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r8i) readonly uniform iimage3D u_image0;
layout (binding = 0, r8i) writeonly uniform iimage3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) readonly uniform image3D u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgb10_a2) readonly uniform image3D u_image0;
layout (binding = 0, rgb10_a2) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) readonly uniform image3D u_image0;
layout (binding = 1, rgba16) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16) readonly uniform image3D u_image0;
layout (binding = 0, rgba16) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) readonly uniform image3D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rgba16_snorm) readonly uniform image3D u_image0;
layout (binding = 0, rgba16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) readonly uniform image3D u_image0;
layout (binding = 1, rg16) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16) readonly uniform image3D u_image0;
layout (binding = 0, rg16) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) readonly uniform image3D u_image0;
layout (binding = 1, r16) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16) readonly uniform image3D u_image0;
layout (binding = 0, r16) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) readonly uniform image3D u_image0;
layout (binding = 1, rg8) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg8) readonly uniform image3D u_image0;
layout (binding = 0, rg8) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) readonly uniform image3D u_image0;
layout (binding = 1, r8) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r8) readonly uniform image3D u_image0;
layout (binding = 0, r8) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) readonly uniform image3D u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg16_snorm) readonly uniform image3D u_image0;
layout (binding = 0, rg16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) readonly uniform image3D u_image0;
layout (binding = 1, r16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r16_snorm) readonly uniform image3D u_image0;
layout (binding = 0, r16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) readonly uniform image3D u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, rg8_snorm) readonly uniform image3D u_image0;
layout (binding = 0, rg8_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) readonly uniform image3D u_image0;
layout (binding = 1, r8_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeAvailable);
}
#version 450

#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 1, r8_snorm) readonly uniform image3D u_image0;
layout (binding = 0, r8_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(pos.x, pos.y, pos.z)));
}
