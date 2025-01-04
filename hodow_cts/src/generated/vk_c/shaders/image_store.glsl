#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 100000, 100000);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 1000, 1000);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 32767, 32767);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 127, 127);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 32767, 32767);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 127, 127);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(5000, 5000, 5000, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(511, 511, 511, 1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform image1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimage1D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = clamp(ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz), ivec4(-512, -512, -512, -2), ivec4(511, 511, 511, 1))-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 100000, 100000);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 1000, 1000);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 32767, 32767);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 127, 127);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 32767, 32767);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 127, 127);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(5000, 5000, 5000, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(511, 511, 511, 1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimage1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform image1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform image1D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimage1DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = clamp(ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(7-gy)^gz, (63-gx)^(7-gy)^gz), ivec4(-512, -512, -512, -2), ivec4(511, 511, 511, 1))-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 100000, 100000);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 1000, 1000);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 32767, 32767);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 127, 127);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 32767, 32767);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 127, 127);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(5000, 5000, 5000, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(511, 511, 511, 1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform image2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimage2D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = clamp(ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), ivec4(-512, -512, -512, -2), ivec4(511, 511, 511, 1))-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 100000, 100000);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 1000, 1000);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 32767, 32767);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 127, 127);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 32767, 32767);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 127, 127);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(5000, 5000, 5000, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(511, 511, 511, 1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimage2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform image2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform image2D u_image;
layout (binding = 1) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec2(gx, gy), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimage2DArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = clamp(ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), ivec4(-512, -512, -512, -2), ivec4(511, 511, 511, 1))-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 100000, 100000);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 1000, 1000);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 32767, 32767);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 127, 127);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 32767, 32767);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 127, 127);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(5000, 5000, 5000, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(511, 511, 511, 1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform image3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimage3D u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = clamp(ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), ivec4(-512, -512, -512, -2), ivec4(511, 511, 511, 1))-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 100000, 100000);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 1000, 1000);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 32767, 32767);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 127, 127);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 32767, 32767);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 127, 127);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(5000, 5000, 5000, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(511, 511, 511, 1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform imageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimageCube u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = clamp(ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), ivec4(-512, -512, -512, -2), ivec4(511, 511, 511, 1))-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 100000, 100000);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 1000, 1000);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 32767, 32767);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 127, 127);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 32767, 32767);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 127, 127);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(5000, 5000, 5000, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(511, 511, 511, 1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.015873;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform imageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimageCubeArray u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = clamp(ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(63-gy)^gz, (63-gx)^(63-gy)^gz), ivec4(-512, -512, -512, -2), ivec4(511, 511, 511, 1))-32;
    imageStore(u_image, ivec3(gx, gy, gz), storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 100000, 100000);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 1000, 1000);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 32767, 32767);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 127, 127);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 2147483520, 2147483520);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 32767, 32767);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 127, 127);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(5000, 5000, 5000, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(100000, 100000, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 1000, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1000, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = clamp(uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz), uvec4(0, 0, 0, 0), uvec4(1023, 1023, 1023, 3));
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(511, 511, 511, 1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 32767, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(32767, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 127, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform uimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    uvec4 storedColor = uvec4(127, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(2147483520, 2147483520, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 32767, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(32767, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 127, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)-32;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = ivec4(127, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0.5, 0.5);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 1, 1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0.5, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.015873;
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(0.5, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 1, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz)*0.031746 + float(-1);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform imageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    vec4 storedColor = vec4(1, 0, 0, 0);
    imageStore(u_image, gx, storedColor);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) writeonly uniform iimageBuffer u_image;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    ivec4 storedColor = clamp(ivec4(gx^gy^gz, (63-gx)^gy^gz, gx^(0-gy)^gz, (63-gx)^(0-gy)^gz), ivec4(-512, -512, -512, -2), ivec4(511, 511, 511, 1))-32;
    imageStore(u_image, gx, storedColor);
}
