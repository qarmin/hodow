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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
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
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, r64i) writeonly uniform highp i64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), i64vec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, r32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, r16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, r8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
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
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, r64ui) writeonly uniform highp u64imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), u64vec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, r32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, r16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, r8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, r16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, r8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, r16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, r8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rg32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rg16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rg8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rg32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rg16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rg8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rg16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rg8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rg16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rg8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rgba32i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rgba16i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rgba32ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rgba16ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rgba8ui) writeonly uniform highp uimageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), uvec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rgba16) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rgba8) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rgba16_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 36) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 36 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 32) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 48) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 48 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 18) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 18) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rgba8_snorm) writeonly uniform highp imageCubeArray u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 18 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
