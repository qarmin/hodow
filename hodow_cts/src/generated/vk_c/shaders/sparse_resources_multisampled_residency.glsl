#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32f) uniform image2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,vec4(2));
    vec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = vec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32f) uniform image2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,vec4(4));
    vec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = vec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32f) uniform image2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,vec4(8));
    vec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = vec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32f) uniform image2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,vec4(16));
    vec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = vec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba16f) uniform image2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,vec4(2));
    vec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = vec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba16f) uniform image2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,vec4(4));
    vec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = vec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba16f) uniform image2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,vec4(8));
    vec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = vec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba16f) uniform image2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,vec4(16));
    vec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = vec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, r32f) uniform image2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,vec4(2));
    vec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = vec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, r32f) uniform image2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,vec4(4));
    vec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = vec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, r32f) uniform image2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,vec4(8));
    vec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = vec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, r32f) uniform image2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,vec4(16));
    vec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = vec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(2));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(4));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(8));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(16));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba16ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(2));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba16ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(4));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba16ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(8));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba16ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(16));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba8ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(2));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba8ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(4));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba8ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(8));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba8ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(16));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, r32ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(2));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, r32ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(4));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, r32ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(8));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, r32ui) uniform uimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,uvec4(16));
    uvec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = uvec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(2));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(4));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(8));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(16));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba16i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(2));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba16i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(4));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba16i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(8));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba16i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(16));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba8i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(2));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba8i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(4));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba8i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(8));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba8i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(16));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, r32i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(2));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, r32i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(4));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, r32i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(8));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
#version 450

#extension GL_ARB_sparse_texture2 : require

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (set = 0, binding = 0, r32i) uniform iimage2DMS u_msImage;
layout (set = 0, binding = 1, r32ui)  writeonly uniform uimage2D  u_resultImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    imageStore(u_msImage, ivec2(gx, gy), 0,ivec4(16));
    ivec4 color;
    sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    int code = sparseImageLoadARB(u_msImage, ivec2(gx, gy), 0, color);
    if (!sparseTexelsResidentARB(code)) {
        color = ivec4(0);
    }
    imageStore(u_resultImage, ivec2(gx, gy), uvec4(color));
}
