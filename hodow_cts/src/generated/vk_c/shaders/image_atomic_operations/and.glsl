#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimage1D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage1D u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint data[];
} inBuffer;

#define TOVEC4(x) uvec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, gx, TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimage1D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage1D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint(imageLoad(u_resultImage, gx).x);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimage1D;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage1D u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, gx % 64, uint(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimage1D; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage1D u_resultImage;
layout (r32ui, binding=1) writeonly uniform uimage1D u_intermValuesImage;

#define TOVEC4(x) uvec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, gx, TOVEC4(imageAtomicAnd(u_resultImage, gx % 64, uint(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimage1D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage1D u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int data[];
} inBuffer;

#define TOVEC4(x) ivec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, gx, TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimage1D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage1D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int(imageLoad(u_resultImage, gx).x);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimage1D;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage1D u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, gx % 64, int(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimage1D; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage1D u_resultImage;
layout (r32i, binding=1) writeonly uniform iimage1D u_intermValuesImage;

#define TOVEC4(x) ivec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, gx, TOVEC4(imageAtomicAnd(u_resultImage, gx % 64, int(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image1D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image1D u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint64_t data[];
} inBuffer;

#define TOVEC4(x) u64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, gx, TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image1D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image1D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint64_t(imageLoad(u_resultImage, gx).x);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image1D;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image1D u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, gx % 64, uint64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image1D; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image1D u_resultImage;
layout (r64ui, binding=1) writeonly uniform u64image1D u_intermValuesImage;

#define TOVEC4(x) u64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, gx, TOVEC4(imageAtomicAnd(u_resultImage, gx % 64, uint64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image1D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image1D u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int64_t data[];
} inBuffer;

#define TOVEC4(x) i64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, gx, TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image1D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image1D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int64_t(imageLoad(u_resultImage, gx).x);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image1D;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image1D u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, gx % 64, int64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image1D; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image1D u_resultImage;
layout (r64i, binding=1) writeonly uniform i64image1D u_intermValuesImage;

#define TOVEC4(x) i64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, gx, TOVEC4(imageAtomicAnd(u_resultImage, gx % 64, int64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimage1DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage1DArray u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint data[];
} inBuffer;

#define TOVEC4(x) uvec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec2(gx,gy), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimage1DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage1DArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint(imageLoad(u_resultImage, ivec2(gx,gy)).x);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimage1DArray;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage1DArray u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), uint(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimage1DArray; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage1DArray u_resultImage;
layout (r32ui, binding=1) writeonly uniform uimage1DArray u_intermValuesImage;

#define TOVEC4(x) uvec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec2(gx,gy), TOVEC4(imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), uint(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimage1DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage1DArray u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int data[];
} inBuffer;

#define TOVEC4(x) ivec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec2(gx,gy), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimage1DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage1DArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int(imageLoad(u_resultImage, ivec2(gx,gy)).x);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimage1DArray;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage1DArray u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), int(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimage1DArray; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage1DArray u_resultImage;
layout (r32i, binding=1) writeonly uniform iimage1DArray u_intermValuesImage;

#define TOVEC4(x) ivec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec2(gx,gy), TOVEC4(imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), int(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image1DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image1DArray u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint64_t data[];
} inBuffer;

#define TOVEC4(x) u64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec2(gx,gy), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image1DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image1DArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint64_t(imageLoad(u_resultImage, ivec2(gx,gy)).x);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image1DArray;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image1DArray u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), uint64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image1DArray; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image1DArray u_resultImage;
layout (r64ui, binding=1) writeonly uniform u64image1DArray u_intermValuesImage;

#define TOVEC4(x) u64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec2(gx,gy), TOVEC4(imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), uint64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image1DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image1DArray u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int64_t data[];
} inBuffer;

#define TOVEC4(x) i64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec2(gx,gy), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image1DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image1DArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int64_t(imageLoad(u_resultImage, ivec2(gx,gy)).x);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image1DArray;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image1DArray u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), int64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image1DArray; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image1DArray u_resultImage;
layout (r64i, binding=1) writeonly uniform i64image1DArray u_intermValuesImage;

#define TOVEC4(x) i64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec2(gx,gy), TOVEC4(imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), int64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimage2D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage2D u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint data[];
} inBuffer;

#define TOVEC4(x) uvec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec2(gx,gy), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimage2D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage2D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint(imageLoad(u_resultImage, ivec2(gx,gy)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimage2D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage2D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint(imageLoad(u_resultImage, ivec2(gx,gy)).x);
    uvec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec2(gx,gy), sparseValue);
    if (outBuffer.data[index] != uint(sparseValue))
        outBuffer.data[index] = uint(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimage2D;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage2D u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), uint(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimage2D; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage2D u_resultImage;
layout (r32ui, binding=1) writeonly uniform uimage2D u_intermValuesImage;

#define TOVEC4(x) uvec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec2(gx,gy), TOVEC4(imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), uint(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimage2D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage2D u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int data[];
} inBuffer;

#define TOVEC4(x) ivec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec2(gx,gy), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimage2D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage2D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int(imageLoad(u_resultImage, ivec2(gx,gy)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimage2D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage2D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int(imageLoad(u_resultImage, ivec2(gx,gy)).x);
    ivec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec2(gx,gy), sparseValue);
    if (outBuffer.data[index] != int(sparseValue))
        outBuffer.data[index] = int(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimage2D;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage2D u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), int(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimage2D; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage2D u_resultImage;
layout (r32i, binding=1) writeonly uniform iimage2D u_intermValuesImage;

#define TOVEC4(x) ivec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec2(gx,gy), TOVEC4(imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), int(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image2D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image2D u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint64_t data[];
} inBuffer;

#define TOVEC4(x) u64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec2(gx,gy), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image2D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image2D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint64_t(imageLoad(u_resultImage, ivec2(gx,gy)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image2D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image2D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint64_t(imageLoad(u_resultImage, ivec2(gx,gy)).x);
    u64vec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec2(gx,gy), sparseValue);
    if (outBuffer.data[index] != uint64_t(sparseValue))
        outBuffer.data[index] = uint64_t(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image2D;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image2D u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), uint64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image2D; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image2D u_resultImage;
layout (r64ui, binding=1) writeonly uniform u64image2D u_intermValuesImage;

#define TOVEC4(x) u64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec2(gx,gy), TOVEC4(imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), uint64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image2D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image2D u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int64_t data[];
} inBuffer;

#define TOVEC4(x) i64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec2(gx,gy), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image2D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image2D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int64_t(imageLoad(u_resultImage, ivec2(gx,gy)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image2D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image2D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int64_t(imageLoad(u_resultImage, ivec2(gx,gy)).x);
    i64vec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec2(gx,gy), sparseValue);
    if (outBuffer.data[index] != int64_t(sparseValue))
        outBuffer.data[index] = int64_t(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image2D;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image2D u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), int64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image2D; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image2D u_resultImage;
layout (r64i, binding=1) writeonly uniform i64image2D u_intermValuesImage;

#define TOVEC4(x) i64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec2(gx,gy), TOVEC4(imageAtomicAnd(u_resultImage, ivec2(gx % 64,gy), int64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimage2DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage2DArray u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint data[];
} inBuffer;

#define TOVEC4(x) uvec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimage2DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage2DArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimage2DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage2DArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    uvec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != uint(sparseValue))
        outBuffer.data[index] = uint(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimage2DArray;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage2DArray u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), uint(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimage2DArray; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage2DArray u_resultImage;
layout (r32ui, binding=1) writeonly uniform uimage2DArray u_intermValuesImage;

#define TOVEC4(x) uvec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), uint(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimage2DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage2DArray u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int data[];
} inBuffer;

#define TOVEC4(x) ivec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimage2DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage2DArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimage2DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage2DArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    ivec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != int(sparseValue))
        outBuffer.data[index] = int(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimage2DArray;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage2DArray u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), int(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimage2DArray; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage2DArray u_resultImage;
layout (r32i, binding=1) writeonly uniform iimage2DArray u_intermValuesImage;

#define TOVEC4(x) ivec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), int(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image2DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image2DArray u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint64_t data[];
} inBuffer;

#define TOVEC4(x) u64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image2DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image2DArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image2DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image2DArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    u64vec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != uint64_t(sparseValue))
        outBuffer.data[index] = uint64_t(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image2DArray;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image2DArray u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), uint64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image2DArray; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image2DArray u_resultImage;
layout (r64ui, binding=1) writeonly uniform u64image2DArray u_intermValuesImage;

#define TOVEC4(x) u64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), uint64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image2DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image2DArray u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int64_t data[];
} inBuffer;

#define TOVEC4(x) i64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image2DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image2DArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image2DArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image2DArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    i64vec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != int64_t(sparseValue))
        outBuffer.data[index] = int64_t(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image2DArray;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image2DArray u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), int64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image2DArray; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image2DArray u_resultImage;
layout (r64i, binding=1) writeonly uniform i64image2DArray u_intermValuesImage;

#define TOVEC4(x) i64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), int64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimage3D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage3D u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint data[];
} inBuffer;

#define TOVEC4(x) uvec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimage3D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage3D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimage3D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage3D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    uvec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != uint(sparseValue))
        outBuffer.data[index] = uint(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimage3D;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage3D u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 48,gy,gz), uint(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimage3D; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage3D u_resultImage;
layout (r32ui, binding=1) writeonly uniform uimage3D u_intermValuesImage;

#define TOVEC4(x) uvec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 48,gy,gz), uint(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimage3D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage3D u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int data[];
} inBuffer;

#define TOVEC4(x) ivec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimage3D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage3D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimage3D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage3D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    ivec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != int(sparseValue))
        outBuffer.data[index] = int(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimage3D;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage3D u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 48,gy,gz), int(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimage3D; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage3D u_resultImage;
layout (r32i, binding=1) writeonly uniform iimage3D u_intermValuesImage;

#define TOVEC4(x) ivec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 48,gy,gz), int(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image3D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image3D u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint64_t data[];
} inBuffer;

#define TOVEC4(x) u64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image3D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image3D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image3D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image3D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    u64vec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != uint64_t(sparseValue))
        outBuffer.data[index] = uint64_t(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image3D;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image3D u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 48,gy,gz), uint64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64image3D; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64image3D u_resultImage;
layout (r64ui, binding=1) writeonly uniform u64image3D u_intermValuesImage;

#define TOVEC4(x) u64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 48,gy,gz), uint64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image3D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image3D u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int64_t data[];
} inBuffer;

#define TOVEC4(x) i64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image3D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image3D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image3D;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image3D u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    i64vec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != int64_t(sparseValue))
        outBuffer.data[index] = int64_t(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image3D;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image3D u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 48,gy,gz), int64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64image3D; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64image3D u_resultImage;
layout (r64i, binding=1) writeonly uniform i64image3D u_intermValuesImage;

#define TOVEC4(x) i64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 48,gy,gz), int64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimageCube;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageCube u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint data[];
} inBuffer;

#define TOVEC4(x) uvec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimageCube;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageCube u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimageCube;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageCube u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    uvec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != uint(sparseValue))
        outBuffer.data[index] = uint(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimageCube;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageCube u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), uint(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimageCube; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageCube u_resultImage;
layout (r32ui, binding=1) writeonly uniform uimageCube u_intermValuesImage;

#define TOVEC4(x) uvec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), uint(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimageCube;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageCube u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int data[];
} inBuffer;

#define TOVEC4(x) ivec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimageCube;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageCube u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimageCube;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageCube u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    ivec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != int(sparseValue))
        outBuffer.data[index] = int(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimageCube;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageCube u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), int(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimageCube; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageCube u_resultImage;
layout (r32i, binding=1) writeonly uniform iimageCube u_intermValuesImage;

#define TOVEC4(x) ivec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), int(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64imageCube;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64imageCube u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint64_t data[];
} inBuffer;

#define TOVEC4(x) u64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64imageCube;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64imageCube u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64imageCube;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64imageCube u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    u64vec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != uint64_t(sparseValue))
        outBuffer.data[index] = uint64_t(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64imageCube;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64imageCube u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), uint64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64imageCube; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64imageCube u_resultImage;
layout (r64ui, binding=1) writeonly uniform u64imageCube u_intermValuesImage;

#define TOVEC4(x) u64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), uint64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64imageCube;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64imageCube u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int64_t data[];
} inBuffer;

#define TOVEC4(x) i64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64imageCube;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64imageCube u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64imageCube;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64imageCube u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    i64vec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != int64_t(sparseValue))
        outBuffer.data[index] = int64_t(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64imageCube;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64imageCube u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), int64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64imageCube; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64imageCube u_resultImage;
layout (r64i, binding=1) writeonly uniform i64imageCube u_intermValuesImage;

#define TOVEC4(x) i64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), int64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimageCubeArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageCubeArray u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint data[];
} inBuffer;

#define TOVEC4(x) uvec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimageCubeArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageCubeArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimageCubeArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageCubeArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    uvec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != uint(sparseValue))
        outBuffer.data[index] = uint(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimageCubeArray;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageCubeArray u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), uint(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimageCubeArray; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageCubeArray u_resultImage;
layout (r32ui, binding=1) writeonly uniform uimageCubeArray u_intermValuesImage;

#define TOVEC4(x) uvec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), uint(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimageCubeArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageCubeArray u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int data[];
} inBuffer;

#define TOVEC4(x) ivec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimageCubeArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageCubeArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimageCubeArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageCubeArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    ivec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != int(sparseValue))
        outBuffer.data[index] = int(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimageCubeArray;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageCubeArray u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), int(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimageCubeArray; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageCubeArray u_resultImage;
layout (r32i, binding=1) writeonly uniform iimageCubeArray u_intermValuesImage;

#define TOVEC4(x) ivec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), int(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64imageCubeArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64imageCubeArray u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint64_t data[];
} inBuffer;

#define TOVEC4(x) u64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64imageCubeArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64imageCubeArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64imageCubeArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64imageCubeArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    u64vec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != uint64_t(sparseValue))
        outBuffer.data[index] = uint64_t(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64imageCubeArray;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64imageCubeArray u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), uint64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64imageCubeArray; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64imageCubeArray u_resultImage;
layout (r64ui, binding=1) writeonly uniform u64imageCubeArray u_intermValuesImage;

#define TOVEC4(x) u64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), uint64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64imageCubeArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64imageCubeArray u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int64_t data[];
} inBuffer;

#define TOVEC4(x) i64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, ivec3(gx,gy,gz), TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64imageCubeArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64imageCubeArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
}
#version 450
#extension GL_ARB_sparse_texture2 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64imageCubeArray;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64imageCubeArray u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int64_t(imageLoad(u_resultImage, ivec3(gx,gy,gz)).x);
    i64vec4 sparseValue;
    sparseImageLoadARB(u_resultImage, ivec3(gx,gy,gz), sparseValue);
    if (outBuffer.data[index] != int64_t(sparseValue))
        outBuffer.data[index] = int64_t(1234);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64imageCubeArray;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64imageCubeArray u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), int64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64imageCubeArray; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64imageCubeArray u_resultImage;
layout (r64i, binding=1) writeonly uniform i64imageCubeArray u_intermValuesImage;

#define TOVEC4(x) i64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, ivec3(gx,gy,gz), TOVEC4(imageAtomicAnd(u_resultImage, ivec3(gx % 64,gy,gz), int64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimageBuffer;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageBuffer u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint data[];
} inBuffer;

#define TOVEC4(x) uvec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, gx, TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp uimageBuffer;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageBuffer u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint(imageLoad(u_resultImage, gx).x);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimageBuffer;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageBuffer u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, gx % 64, uint(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp uimageBuffer; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageBuffer u_resultImage;
layout (r32ui, binding=1) writeonly uniform uimageBuffer u_intermValuesImage;

#define TOVEC4(x) uvec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, gx, TOVEC4(imageAtomicAnd(u_resultImage, gx % 64, uint(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimageBuffer;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageBuffer u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int data[];
} inBuffer;

#define TOVEC4(x) ivec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, gx, TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
precision highp iimageBuffer;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageBuffer u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int(imageLoad(u_resultImage, gx).x);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimageBuffer;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageBuffer u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, gx % 64, int(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

precision highp iimageBuffer; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageBuffer u_resultImage;
layout (r32i, binding=1) writeonly uniform iimageBuffer u_intermValuesImage;

#define TOVEC4(x) ivec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, gx, TOVEC4(imageAtomicAnd(u_resultImage, gx % 64, int(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64imageBuffer;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64imageBuffer u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    uint64_t data[];
} inBuffer;

#define TOVEC4(x) u64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, gx, TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64imageBuffer;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64imageBuffer u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    uint64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = uint64_t(imageLoad(u_resultImage, gx).x);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64imageBuffer;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64imageBuffer u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, gx % 64, uint64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp u64imageBuffer; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) coherent uniform u64imageBuffer u_resultImage;
layout (r64ui, binding=1) writeonly uniform u64imageBuffer u_intermValuesImage;

#define TOVEC4(x) u64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, gx, TOVEC4(imageAtomicAnd(u_resultImage, gx % 64, uint64_t(gx*gx + gy*gy + gz*gz))));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64imageBuffer;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64imageBuffer u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
    int64_t data[];
} inBuffer;

#define TOVEC4(x) i64vec4(x)

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    imageStore(u_resultImage, gx, TOVEC4(inBuffer.data[index]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64imageBuffer;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64imageBuffer u_resultImage;

layout(std430, binding = 1) buffer outputBuffer
{
    int64_t data[];
} outBuffer;

void main(void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
    outBuffer.data[index] = int64_t(imageLoad(u_resultImage, gx).x);
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64imageBuffer;

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64imageBuffer u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageAtomicAnd(u_resultImage, gx % 64, int64_t(gx*gx + gy*gy + gz*gz));
}
#version 450
#extension GL_EXT_shader_atomic_float : enable
#extension GL_EXT_shader_atomic_float2 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_NV_shader_atomic_fp16_vector : enable

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
precision highp i64imageBuffer; 
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) coherent uniform i64imageBuffer u_resultImage;
layout (r64i, binding=1) writeonly uniform i64imageBuffer u_intermValuesImage;

#define TOVEC4(x) i64vec4(x)

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_intermValuesImage, gx, TOVEC4(imageAtomicAnd(u_resultImage, gx % 64, int64_t(gx*gx + gy*gy + gz*gz))));
}
