#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform image1D u_image0;
layout (binding = 1, rgba32f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, rgba32f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) readonly uniform image1D u_image0;
layout (binding = 1, rgba16f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, rgba16f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) readonly uniform image1D u_image0;
layout (binding = 1, r32f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, r32f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1D u_image0;
layout (binding = 1) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1D u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) readonly uniform uimage1D u_image0;
layout (binding = 1, r32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1D u_image0;
layout (binding = 1, r32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1D u_image0;
layout (binding = 1) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) readonly uniform iimage1D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) readonly uniform iimage1D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) readonly uniform iimage1D u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1D u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) readonly uniform iimage1D u_image0;
layout (binding = 1, r32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1D u_image0;
layout (binding = 1, r32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) readonly uniform image1D u_image0;
layout (binding = 1, rgba8) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, rgba8) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) readonly uniform image1D u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) readonly uniform image1D u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) readonly uniform image1D u_image0;
layout (binding = 1, rg32f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, rg32f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) readonly uniform image1D u_image0;
layout (binding = 1, rg16f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, rg16f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) readonly uniform image1D u_image0;
layout (binding = 1, r16f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, r16f) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1D u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1D u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) readonly uniform uimage1D u_image0;
layout (binding = 1, r16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1D u_image0;
layout (binding = 1, r16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1D u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) readonly uniform uimage1D u_image0;
layout (binding = 1, r8ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1D u_image0;
layout (binding = 1, r8ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) readonly uniform iimage1D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) readonly uniform iimage1D u_image0;
layout (binding = 1, rg16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1D u_image0;
layout (binding = 1, rg16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) readonly uniform iimage1D u_image0;
layout (binding = 1, r16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1D u_image0;
layout (binding = 1, r16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) readonly uniform iimage1D u_image0;
layout (binding = 1, rg8i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1D u_image0;
layout (binding = 1, rg8i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) readonly uniform iimage1D u_image0;
layout (binding = 1, r8i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1D u_image0;
layout (binding = 1, r8i) writeonly uniform iimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) readonly uniform image1D u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) readonly uniform image1D u_image0;
layout (binding = 1, rgba16) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, rgba16) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) readonly uniform image1D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) readonly uniform image1D u_image0;
layout (binding = 1, rg16) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, rg16) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) readonly uniform image1D u_image0;
layout (binding = 1, r16) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, r16) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) readonly uniform image1D u_image0;
layout (binding = 1, rg8) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, rg8) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) readonly uniform image1D u_image0;
layout (binding = 1, r8) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, r8) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) readonly uniform image1D u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) readonly uniform image1D u_image0;
layout (binding = 1, r16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, r16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) readonly uniform image1D u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) readonly uniform image1D u_image0;
layout (binding = 1, r8_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1D u_image0;
layout (binding = 1, r8_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) restrict readonly uniform uimage1D u_image0;
layout (binding = 1, rgba32ui) restrict writeonly uniform uimage1D u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform image1DArray u_image0;
layout (binding = 1, rgba32f) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, rgba32f) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) readonly uniform image1DArray u_image0;
layout (binding = 1, rgba16f) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, rgba16f) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) readonly uniform image1DArray u_image0;
layout (binding = 1, r32f) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, r32f) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1DArray u_image0;
layout (binding = 1) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) readonly uniform uimage1DArray u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1DArray u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) readonly uniform uimage1DArray u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1DArray u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) readonly uniform uimage1DArray u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1DArray u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) readonly uniform uimage1DArray u_image0;
layout (binding = 1, r32ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1DArray u_image0;
layout (binding = 1, r32ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1DArray u_image0;
layout (binding = 1) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) readonly uniform iimage1DArray u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1DArray u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) readonly uniform iimage1DArray u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1DArray u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) readonly uniform iimage1DArray u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1DArray u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) readonly uniform iimage1DArray u_image0;
layout (binding = 1, r32i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1DArray u_image0;
layout (binding = 1, r32i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) readonly uniform image1DArray u_image0;
layout (binding = 1, rgba8) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, rgba8) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) readonly uniform image1DArray u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) readonly uniform image1DArray u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) readonly uniform image1DArray u_image0;
layout (binding = 1, rg32f) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, rg32f) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) readonly uniform image1DArray u_image0;
layout (binding = 1, rg16f) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, rg16f) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) readonly uniform image1DArray u_image0;
layout (binding = 1, r16f) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, r16f) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) readonly uniform uimage1DArray u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1DArray u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) readonly uniform uimage1DArray u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1DArray u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) readonly uniform uimage1DArray u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1DArray u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) readonly uniform uimage1DArray u_image0;
layout (binding = 1, r16ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1DArray u_image0;
layout (binding = 1, r16ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) readonly uniform uimage1DArray u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1DArray u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) readonly uniform uimage1DArray u_image0;
layout (binding = 1, r8ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage1DArray u_image0;
layout (binding = 1, r8ui) writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) readonly uniform iimage1DArray u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1DArray u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) readonly uniform iimage1DArray u_image0;
layout (binding = 1, rg16i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1DArray u_image0;
layout (binding = 1, rg16i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) readonly uniform iimage1DArray u_image0;
layout (binding = 1, r16i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1DArray u_image0;
layout (binding = 1, r16i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) readonly uniform iimage1DArray u_image0;
layout (binding = 1, rg8i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1DArray u_image0;
layout (binding = 1, rg8i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) readonly uniform iimage1DArray u_image0;
layout (binding = 1, r8i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage1DArray u_image0;
layout (binding = 1, r8i) writeonly uniform iimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) readonly uniform image1DArray u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) readonly uniform image1DArray u_image0;
layout (binding = 1, rgba16) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, rgba16) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) readonly uniform image1DArray u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) readonly uniform image1DArray u_image0;
layout (binding = 1, rg16) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, rg16) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) readonly uniform image1DArray u_image0;
layout (binding = 1, r16) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, r16) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) readonly uniform image1DArray u_image0;
layout (binding = 1, rg8) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, rg8) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) readonly uniform image1DArray u_image0;
layout (binding = 1, r8) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, r8) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) readonly uniform image1DArray u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) readonly uniform image1DArray u_image0;
layout (binding = 1, r16_snorm) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, r16_snorm) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) readonly uniform image1DArray u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) readonly uniform image1DArray u_image0;
layout (binding = 1, r8_snorm) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image1DArray u_image0;
layout (binding = 1, r8_snorm) writeonly uniform image1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) restrict readonly uniform uimage1DArray u_image0;
layout (binding = 1, rgba32ui) restrict writeonly uniform uimage1DArray u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform image2D u_image0;
layout (binding = 1, rgba32f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, rgba32f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) readonly uniform image2D u_image0;
layout (binding = 1, rgba16f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, rgba16f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) readonly uniform image2D u_image0;
layout (binding = 1, r32f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, r32f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2D u_image0;
layout (binding = 1) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2D u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) readonly uniform uimage2D u_image0;
layout (binding = 1, r32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2D u_image0;
layout (binding = 1, r32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2D u_image0;
layout (binding = 1) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) readonly uniform iimage2D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) readonly uniform iimage2D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) readonly uniform iimage2D u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2D u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) readonly uniform iimage2D u_image0;
layout (binding = 1, r32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2D u_image0;
layout (binding = 1, r32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) readonly uniform image2D u_image0;
layout (binding = 1, rgba8) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, rgba8) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) readonly uniform image2D u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) readonly uniform image2D u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) readonly uniform image2D u_image0;
layout (binding = 1, rg32f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, rg32f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) readonly uniform image2D u_image0;
layout (binding = 1, rg16f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, rg16f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) readonly uniform image2D u_image0;
layout (binding = 1, r16f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, r16f) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2D u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2D u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) readonly uniform uimage2D u_image0;
layout (binding = 1, r16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2D u_image0;
layout (binding = 1, r16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2D u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) readonly uniform uimage2D u_image0;
layout (binding = 1, r8ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2D u_image0;
layout (binding = 1, r8ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) readonly uniform iimage2D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) readonly uniform iimage2D u_image0;
layout (binding = 1, rg16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2D u_image0;
layout (binding = 1, rg16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) readonly uniform iimage2D u_image0;
layout (binding = 1, r16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2D u_image0;
layout (binding = 1, r16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) readonly uniform iimage2D u_image0;
layout (binding = 1, rg8i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2D u_image0;
layout (binding = 1, rg8i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) readonly uniform iimage2D u_image0;
layout (binding = 1, r8i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2D u_image0;
layout (binding = 1, r8i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) readonly uniform image2D u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) readonly uniform image2D u_image0;
layout (binding = 1, rgba16) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, rgba16) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) readonly uniform image2D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) readonly uniform image2D u_image0;
layout (binding = 1, rg16) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, rg16) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) readonly uniform image2D u_image0;
layout (binding = 1, r16) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, r16) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) readonly uniform image2D u_image0;
layout (binding = 1, rg8) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, rg8) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) readonly uniform image2D u_image0;
layout (binding = 1, r8) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, r8) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) readonly uniform image2D u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) readonly uniform image2D u_image0;
layout (binding = 1, r16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, r16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) readonly uniform image2D u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) readonly uniform image2D u_image0;
layout (binding = 1, r8_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2D u_image0;
layout (binding = 1, r8_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) restrict readonly uniform uimage2D u_image0;
layout (binding = 1, rgba32ui) restrict writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec2(63-pos.x, pos.y)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform image2DArray u_image0;
layout (binding = 1, rgba32f) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, rgba32f) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) readonly uniform image2DArray u_image0;
layout (binding = 1, rgba16f) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, rgba16f) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) readonly uniform image2DArray u_image0;
layout (binding = 1, r32f) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, r32f) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2DArray u_image0;
layout (binding = 1) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) readonly uniform uimage2DArray u_image0;
layout (binding = 1, r32ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2DArray u_image0;
layout (binding = 1, r32ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2DArray u_image0;
layout (binding = 1) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) readonly uniform iimage2DArray u_image0;
layout (binding = 1, r32i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2DArray u_image0;
layout (binding = 1, r32i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) readonly uniform image2DArray u_image0;
layout (binding = 1, rgba8) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, rgba8) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) readonly uniform image2DArray u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) readonly uniform image2DArray u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) readonly uniform image2DArray u_image0;
layout (binding = 1, rg32f) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, rg32f) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) readonly uniform image2DArray u_image0;
layout (binding = 1, rg16f) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, rg16f) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) readonly uniform image2DArray u_image0;
layout (binding = 1, r16f) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, r16f) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) readonly uniform uimage2DArray u_image0;
layout (binding = 1, r16ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2DArray u_image0;
layout (binding = 1, r16ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) readonly uniform uimage2DArray u_image0;
layout (binding = 1, r8ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage2DArray u_image0;
layout (binding = 1, r8ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rg16i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rg16i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) readonly uniform iimage2DArray u_image0;
layout (binding = 1, r16i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2DArray u_image0;
layout (binding = 1, r16i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rg8i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rg8i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) readonly uniform iimage2DArray u_image0;
layout (binding = 1, r8i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage2DArray u_image0;
layout (binding = 1, r8i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) readonly uniform image2DArray u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) readonly uniform image2DArray u_image0;
layout (binding = 1, rgba16) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, rgba16) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) readonly uniform image2DArray u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) readonly uniform image2DArray u_image0;
layout (binding = 1, rg16) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, rg16) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) readonly uniform image2DArray u_image0;
layout (binding = 1, r16) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, r16) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) readonly uniform image2DArray u_image0;
layout (binding = 1, rg8) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, rg8) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) readonly uniform image2DArray u_image0;
layout (binding = 1, r8) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, r8) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) readonly uniform image2DArray u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) readonly uniform image2DArray u_image0;
layout (binding = 1, r16_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, r16_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) readonly uniform image2DArray u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) readonly uniform image2DArray u_image0;
layout (binding = 1, r8_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image2DArray u_image0;
layout (binding = 1, r8_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) restrict readonly uniform uimage2DArray u_image0;
layout (binding = 1, rgba32ui) restrict writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform image3D u_image0;
layout (binding = 1, rgba32f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, rgba32f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) readonly uniform image3D u_image0;
layout (binding = 1, rgba16f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, rgba16f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) readonly uniform image3D u_image0;
layout (binding = 1, r32f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, r32f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage3D u_image0;
layout (binding = 1) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage3D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage3D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage3D u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) readonly uniform uimage3D u_image0;
layout (binding = 1, r32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage3D u_image0;
layout (binding = 1, r32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage3D u_image0;
layout (binding = 1) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) readonly uniform iimage3D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage3D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) readonly uniform iimage3D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage3D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) readonly uniform iimage3D u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage3D u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) readonly uniform iimage3D u_image0;
layout (binding = 1, r32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage3D u_image0;
layout (binding = 1, r32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) readonly uniform image3D u_image0;
layout (binding = 1, rgba8) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, rgba8) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) readonly uniform image3D u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) readonly uniform image3D u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) readonly uniform image3D u_image0;
layout (binding = 1, rg32f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, rg32f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) readonly uniform image3D u_image0;
layout (binding = 1, rg16f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, rg16f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) readonly uniform image3D u_image0;
layout (binding = 1, r16f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, r16f) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage3D u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage3D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage3D u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) readonly uniform uimage3D u_image0;
layout (binding = 1, r16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage3D u_image0;
layout (binding = 1, r16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage3D u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) readonly uniform uimage3D u_image0;
layout (binding = 1, r8ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimage3D u_image0;
layout (binding = 1, r8ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) readonly uniform iimage3D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage3D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) readonly uniform iimage3D u_image0;
layout (binding = 1, rg16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage3D u_image0;
layout (binding = 1, rg16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) readonly uniform iimage3D u_image0;
layout (binding = 1, r16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage3D u_image0;
layout (binding = 1, r16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) readonly uniform iimage3D u_image0;
layout (binding = 1, rg8i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage3D u_image0;
layout (binding = 1, rg8i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) readonly uniform iimage3D u_image0;
layout (binding = 1, r8i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimage3D u_image0;
layout (binding = 1, r8i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) readonly uniform image3D u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) readonly uniform image3D u_image0;
layout (binding = 1, rgba16) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, rgba16) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) readonly uniform image3D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) readonly uniform image3D u_image0;
layout (binding = 1, rg16) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, rg16) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) readonly uniform image3D u_image0;
layout (binding = 1, r16) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, r16) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) readonly uniform image3D u_image0;
layout (binding = 1, rg8) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, rg8) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) readonly uniform image3D u_image0;
layout (binding = 1, r8) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, r8) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) readonly uniform image3D u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) readonly uniform image3D u_image0;
layout (binding = 1, r16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, r16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) readonly uniform image3D u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) readonly uniform image3D u_image0;
layout (binding = 1, r8_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform image3D u_image0;
layout (binding = 1, r8_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) restrict readonly uniform uimage3D u_image0;
layout (binding = 1, rgba32ui) restrict writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform imageCube u_image0;
layout (binding = 1, rgba32f) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, rgba32f) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) readonly uniform imageCube u_image0;
layout (binding = 1, rgba16f) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, rgba16f) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) readonly uniform imageCube u_image0;
layout (binding = 1, r32f) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, r32f) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCube u_image0;
layout (binding = 1) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) readonly uniform uimageCube u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCube u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) readonly uniform uimageCube u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCube u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) readonly uniform uimageCube u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCube u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) readonly uniform uimageCube u_image0;
layout (binding = 1, r32ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCube u_image0;
layout (binding = 1, r32ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCube u_image0;
layout (binding = 1) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) readonly uniform iimageCube u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCube u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) readonly uniform iimageCube u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCube u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) readonly uniform iimageCube u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCube u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) readonly uniform iimageCube u_image0;
layout (binding = 1, r32i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCube u_image0;
layout (binding = 1, r32i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) readonly uniform imageCube u_image0;
layout (binding = 1, rgba8) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, rgba8) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) readonly uniform imageCube u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) readonly uniform imageCube u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) readonly uniform imageCube u_image0;
layout (binding = 1, rg32f) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, rg32f) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) readonly uniform imageCube u_image0;
layout (binding = 1, rg16f) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, rg16f) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) readonly uniform imageCube u_image0;
layout (binding = 1, r16f) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, r16f) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) readonly uniform uimageCube u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCube u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) readonly uniform uimageCube u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCube u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) readonly uniform uimageCube u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCube u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) readonly uniform uimageCube u_image0;
layout (binding = 1, r16ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCube u_image0;
layout (binding = 1, r16ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) readonly uniform uimageCube u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCube u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) readonly uniform uimageCube u_image0;
layout (binding = 1, r8ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCube u_image0;
layout (binding = 1, r8ui) writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) readonly uniform iimageCube u_image0;
layout (binding = 1, rg32i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCube u_image0;
layout (binding = 1, rg32i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) readonly uniform iimageCube u_image0;
layout (binding = 1, rg16i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCube u_image0;
layout (binding = 1, rg16i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) readonly uniform iimageCube u_image0;
layout (binding = 1, r16i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCube u_image0;
layout (binding = 1, r16i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) readonly uniform iimageCube u_image0;
layout (binding = 1, rg8i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCube u_image0;
layout (binding = 1, rg8i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) readonly uniform iimageCube u_image0;
layout (binding = 1, r8i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCube u_image0;
layout (binding = 1, r8i) writeonly uniform iimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) readonly uniform imageCube u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) readonly uniform imageCube u_image0;
layout (binding = 1, rgba16) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, rgba16) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) readonly uniform imageCube u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) readonly uniform imageCube u_image0;
layout (binding = 1, rg16) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, rg16) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) readonly uniform imageCube u_image0;
layout (binding = 1, r16) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, r16) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) readonly uniform imageCube u_image0;
layout (binding = 1, rg8) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, rg8) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) readonly uniform imageCube u_image0;
layout (binding = 1, r8) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, r8) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) readonly uniform imageCube u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) readonly uniform imageCube u_image0;
layout (binding = 1, r16_snorm) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, r16_snorm) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) readonly uniform imageCube u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) readonly uniform imageCube u_image0;
layout (binding = 1, r8_snorm) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCube u_image0;
layout (binding = 1, r8_snorm) writeonly uniform imageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) restrict readonly uniform uimageCube u_image0;
layout (binding = 1, rgba32ui) restrict writeonly uniform uimageCube u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rgba32f) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rgba32f) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rgba16f) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rgba16f) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) readonly uniform imageCubeArray u_image0;
layout (binding = 1, r32f) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, r32f) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCubeArray u_image0;
layout (binding = 1) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, r32ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, r32ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCubeArray u_image0;
layout (binding = 1) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, r32i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, r32i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rgba8) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rgba8) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) readonly uniform imageCubeArray u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rg32f) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rg32f) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rg16f) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rg16f) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) readonly uniform imageCubeArray u_image0;
layout (binding = 1, r16f) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, r16f) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, r16ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, r16ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, r8ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageCubeArray u_image0;
layout (binding = 1, r8ui) writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, rg32i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, rg32i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, rg16i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, rg16i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, r16i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, r16i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, rg8i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, rg8i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, r8i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageCubeArray u_image0;
layout (binding = 1, r8i) writeonly uniform iimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rgba16) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rgba16) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rg16) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rg16) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) readonly uniform imageCubeArray u_image0;
layout (binding = 1, r16) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, r16) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rg8) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rg8) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) readonly uniform imageCubeArray u_image0;
layout (binding = 1, r8) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, r8) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) readonly uniform imageCubeArray u_image0;
layout (binding = 1, r16_snorm) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, r16_snorm) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) readonly uniform imageCubeArray u_image0;
layout (binding = 1, r8_snorm) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageCubeArray u_image0;
layout (binding = 1, r8_snorm) writeonly uniform imageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) restrict readonly uniform uimageCubeArray u_image0;
layout (binding = 1, rgba32ui) restrict writeonly uniform uimageCubeArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, ivec3(63-pos.x, pos.y, pos.z)));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform imageBuffer u_image0;
layout (binding = 1, rgba32f) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, rgba32f) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16f) readonly uniform imageBuffer u_image0;
layout (binding = 1, rgba16f) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, rgba16f) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32f) readonly uniform imageBuffer u_image0;
layout (binding = 1, r32f) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, r32f) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageBuffer u_image0;
layout (binding = 1) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) readonly uniform uimageBuffer u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageBuffer u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) readonly uniform uimageBuffer u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageBuffer u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) readonly uniform uimageBuffer u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageBuffer u_image0;
layout (binding = 1, rgba8ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) readonly uniform uimageBuffer u_image0;
layout (binding = 1, r32ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageBuffer u_image0;
layout (binding = 1, r32ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageBuffer u_image0;
layout (binding = 1) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) readonly uniform iimageBuffer u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageBuffer u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) readonly uniform iimageBuffer u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageBuffer u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) readonly uniform iimageBuffer u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageBuffer u_image0;
layout (binding = 1, rgba8i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) readonly uniform iimageBuffer u_image0;
layout (binding = 1, r32i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageBuffer u_image0;
layout (binding = 1, r32i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) readonly uniform imageBuffer u_image0;
layout (binding = 1, rgba8) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, rgba8) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) readonly uniform imageBuffer u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, rgba8_snorm) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r11f_g11f_b10f) readonly uniform imageBuffer u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, r11f_g11f_b10f) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32f) readonly uniform imageBuffer u_image0;
layout (binding = 1, rg32f) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, rg32f) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16f) readonly uniform imageBuffer u_image0;
layout (binding = 1, rg16f) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, rg16f) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16f) readonly uniform imageBuffer u_image0;
layout (binding = 1, r16f) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, r16f) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2ui) readonly uniform uimageBuffer u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageBuffer u_image0;
layout (binding = 1, rgb10_a2ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) readonly uniform uimageBuffer u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageBuffer u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) readonly uniform uimageBuffer u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageBuffer u_image0;
layout (binding = 1, rg16ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) readonly uniform uimageBuffer u_image0;
layout (binding = 1, r16ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageBuffer u_image0;
layout (binding = 1, r16ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) readonly uniform uimageBuffer u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageBuffer u_image0;
layout (binding = 1, rg8ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) readonly uniform uimageBuffer u_image0;
layout (binding = 1, r8ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform uimageBuffer u_image0;
layout (binding = 1, r8ui) writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) readonly uniform iimageBuffer u_image0;
layout (binding = 1, rg32i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageBuffer u_image0;
layout (binding = 1, rg32i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) readonly uniform iimageBuffer u_image0;
layout (binding = 1, rg16i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageBuffer u_image0;
layout (binding = 1, rg16i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) readonly uniform iimageBuffer u_image0;
layout (binding = 1, r16i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageBuffer u_image0;
layout (binding = 1, r16i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) readonly uniform iimageBuffer u_image0;
layout (binding = 1, rg8i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageBuffer u_image0;
layout (binding = 1, rg8i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) readonly uniform iimageBuffer u_image0;
layout (binding = 1, r8i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform iimageBuffer u_image0;
layout (binding = 1, r8i) writeonly uniform iimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgb10_a2) readonly uniform imageBuffer u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, rgb10_a2) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) readonly uniform imageBuffer u_image0;
layout (binding = 1, rgba16) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, rgba16) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) readonly uniform imageBuffer u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) readonly uniform imageBuffer u_image0;
layout (binding = 1, rg16) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, rg16) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) readonly uniform imageBuffer u_image0;
layout (binding = 1, r16) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, r16) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) readonly uniform imageBuffer u_image0;
layout (binding = 1, rg8) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, rg8) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) readonly uniform imageBuffer u_image0;
layout (binding = 1, r8) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, r8) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) readonly uniform imageBuffer u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, rg16_snorm) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) readonly uniform imageBuffer u_image0;
layout (binding = 1, r16_snorm) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, r16_snorm) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) readonly uniform imageBuffer u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, rg8_snorm) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) readonly uniform imageBuffer u_image0;
layout (binding = 1, r8_snorm) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

#extension GL_EXT_shader_image_load_formatted : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0) readonly uniform imageBuffer u_image0;
layout (binding = 1, r8_snorm) writeonly uniform imageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) restrict readonly uniform uimageBuffer u_image0;
layout (binding = 1, rgba32ui) restrict writeonly uniform uimageBuffer u_image1;

void main (void)
{
    int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, 63-pos));
}
