#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimage2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimage2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp image2DArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 137 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, 0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, 0, 0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimage3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(int(gl_GlobalInvocationID.x) % 127, int(gl_GlobalInvocationID.y) % 127, int(gl_GlobalInvocationID.z) % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 16 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1024 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 8 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp image3D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 3 )
    {
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(int(gl_GlobalInvocationID.x) % 127) / 127.0, float(int(gl_GlobalInvocationID.y) % 127) / 127.0, float(int(gl_GlobalInvocationID.z) % 127) / 127.0, 1.0));
    }
}
