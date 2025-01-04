#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r16) writeonly uniform image2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r16) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r16) writeonly uniform image2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r16) writeonly uniform image2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r16) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r16) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r8) writeonly uniform image2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r8_snorm) writeonly uniform image2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r8ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r8_snorm) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r8ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r8) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r16) writeonly uniform image2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r8) writeonly uniform image2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r8_snorm) writeonly uniform image2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r8i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, r8i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r8ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r8i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage2D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image2D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image2D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage2D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image2D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image2D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage2D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image2D image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage2D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage2D image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage2D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage2D image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage2D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);

    if (gl_GlobalInvocationID.y < 128)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2DArray image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DArray image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r16) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r16) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r16) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r16) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r16) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r16) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r8) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r8_snorm) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r8ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r8_snorm) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r8ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r8) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage2DArray image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage2DArray image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r16) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r8) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r8_snorm) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r8i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, r8i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r8ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r8i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DArray image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage2DArray image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image2DArray image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage2DArray image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image2DArray image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage2DArray image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage2DArray image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage2DArray image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage2DArray image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage2DArray image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage3D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image3D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image3D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage3D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image3D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image3D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r16) writeonly uniform image3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r16) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r16) writeonly uniform image3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r16) writeonly uniform image3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r16) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r16) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r8) writeonly uniform image3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r8_snorm) writeonly uniform image3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r8ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r8_snorm) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r8ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r8) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg16i) writeonly uniform iimage3D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg16ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg16) writeonly uniform image3D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg16_snorm) writeonly uniform image3D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba8i) writeonly uniform iimage3D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba8) writeonly uniform image3D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba8_snorm) writeonly uniform image3D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r16) writeonly uniform image3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r16_snorm) writeonly uniform image3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg8i) writeonly uniform iimage3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg8ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg8) writeonly uniform image3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg8_snorm) writeonly uniform image3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r8) writeonly uniform image3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r8_snorm) writeonly uniform image3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r8i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, r8i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r16ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r16i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r8ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(112, 60, 101, 41);
uvec4 color1 = uvec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r8ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r8i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(112, 60, 101, 41);
ivec4 color1 = ivec4(112, 60, 101, 41);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage3D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image3D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image3D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, r32ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, r32ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, r32i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba16i) writeonly uniform iimage3D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba16ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(28784, 15420, 25957, 10537);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba16) writeonly uniform image3D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rgba16_snorm) writeonly uniform image3D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
vec4 color1 = vec4(0, 0.4, 0.8, 0.1);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage3D image1;
ivec4 color0 = ivec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(28784, 15420, 25957, 10537);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rgba16_snorm) writeonly uniform image3D image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage3D image1;
vec4 color0 = vec4(0, 0.4, 0.8, 0.1);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32i) writeonly uniform iimage3D image0;
layout (set = 0, binding = 1, rg32ui) writeonly uniform uimage3D image1;
ivec4 color0 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
uvec4 color1 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0, rg32ui) writeonly uniform uimage3D image0;
layout (set = 0, binding = 1, rg32i) writeonly uniform iimage3D image1;
uvec4 color0 = uvec4(1886417008, 1010580540, 1701143909, 690563369);
ivec4 color1 = ivec4(1886417008, 1010580540, 1701143909, 690563369);
void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);

    if (gl_GlobalInvocationID.y < 256)
    {
        imageStore(image0, pos, color0);
    }
    else
    {
        imageStore(image1, pos, color1);
    }
}
