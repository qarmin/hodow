#version 460 core

layout (rgba32f, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rg32f, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (r32f, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rgba16f, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rg16f, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (r16f, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rgba16, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rg16, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (r16, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rgba16_snorm, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rg16_snorm, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (r16_snorm, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rgb10_a2, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (r11f_g11f_b10f, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rgba8, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rg8, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (r8, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rgba8_snorm, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rg8_snorm, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (r8_snorm, binding=0) uniform image2D inputImage;

void main()
{
    vec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rgba32i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rg32i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (r32i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rgba16i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rg16i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (r16i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rgba8i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rg8i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (r8i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rgba32ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rg32ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (r32ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rgba16ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rg16ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (r16ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rgb10_a2ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rgba8ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rg8ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (r8ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 value = imageLoad(inputImage, ivec2(gl_GlobalInvocationID.xy));
}
#version 460 core

layout (rgba32f, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (rg32f, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (r32f, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (rgba16f, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (rg16f, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (r16f, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (rgba16, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (rg16, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (r16, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (rgba16_snorm, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (rg16_snorm, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (r16_snorm, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (rgb10_a2, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (r11f_g11f_b10f, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (rgba8, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (rg8, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (r8, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (rgba8_snorm, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (rg8_snorm, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (r8_snorm, binding=0) uniform image2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), vec4(0.25, 0.5, 0.0, 1.0));
}
#version 460 core

layout (rgba32i, binding=0) uniform iimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), ivec4(-1, 2, -1000, 2000));
}
#version 460 core

layout (rg32i, binding=0) uniform iimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), ivec4(-1, 2, -1000, 2000));
}
#version 460 core

layout (r32i, binding=0) uniform iimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), ivec4(-1, 2, -1000, 2000));
}
#version 460 core

layout (rgba16i, binding=0) uniform iimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), ivec4(-1, 2, -1000, 2000));
}
#version 460 core

layout (rg16i, binding=0) uniform iimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), ivec4(-1, 2, -1000, 2000));
}
#version 460 core

layout (r16i, binding=0) uniform iimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), ivec4(-1, 2, -1000, 2000));
}
#version 460 core

layout (rgba8i, binding=0) uniform iimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), ivec4(-1, 2, -1000, 2000));
}
#version 460 core

layout (rg8i, binding=0) uniform iimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), ivec4(-1, 2, -1000, 2000));
}
#version 460 core

layout (r8i, binding=0) uniform iimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), ivec4(-1, 2, -1000, 2000));
}
#version 460 core

layout (rgba32ui, binding=0) uniform uimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), uvec4(1, 10, 100, 1000));
}
#version 460 core

layout (rg32ui, binding=0) uniform uimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), uvec4(1, 10, 100, 1000));
}
#version 460 core

layout (r32ui, binding=0) uniform uimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), uvec4(1, 10, 100, 1000));
}
#version 460 core

layout (rgba16ui, binding=0) uniform uimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), uvec4(1, 10, 100, 1000));
}
#version 460 core

layout (rg16ui, binding=0) uniform uimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), uvec4(1, 10, 100, 1000));
}
#version 460 core

layout (r16ui, binding=0) uniform uimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), uvec4(1, 10, 100, 1000));
}
#version 460 core

layout (rgb10_a2ui, binding=0) uniform uimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), uvec4(1, 10, 100, 1000));
}
#version 460 core

layout (rgba8ui, binding=0) uniform uimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), uvec4(1, 10, 100, 1000));
}
#version 460 core

layout (rg8ui, binding=0) uniform uimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), uvec4(1, 10, 100, 1000));
}
#version 460 core

layout (r8ui, binding=0) uniform uimage2D inputImage;

void main()
{
    imageStore(inputImage, ivec2(gl_GlobalInvocationID.xy), uvec4(1, 10, 100, 1000));
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rgba32f, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rg32f, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (r32f, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rgba16f, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rg16f, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (r16f, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rgba16, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rg16, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (r16, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rgba16_snorm, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rg16_snorm, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (r16_snorm, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rgb10_a2, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (r11f_g11f_b10f, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rgba8, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rg8, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (r8, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rgba8_snorm, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rg8_snorm, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (r8_snorm, binding=0) uniform image2D inputImage;

void main()
{
    vec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rgba32i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rg32i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (r32i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rgba16i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rg16i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (r16i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rgba8i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rg8i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (r8i, binding=0) uniform iimage2D inputImage;

void main()
{
    ivec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rgba32ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rg32ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (r32ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rgba16ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rg16ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (r16ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rgb10_a2ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rgba8ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (rg8ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
#version 460 core
#extension GL_ARB_sparse_texture2 : require

layout (r8ui, binding=0) uniform uimage2D inputImage;

void main()
{
    uvec4 result;
    int r = sparseImageLoadARB(inputImage, ivec2(gl_GlobalInvocationID.xy), result);
}
