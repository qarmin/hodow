#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 6) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 6) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 6) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 137 * logicalY + 137 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 68, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 68 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 68 * logicalY + 68 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 34, local_size_y = 3, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 34 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 34 * logicalY + 34 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 17, local_size_y = 7, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 17 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 17 * logicalY + 17 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 11 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 11 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 5, local_size_z = 5) in;
layout (binding = 0, rgba8i) writeonly uniform highp iimageCube u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 5 )
    if( gl_GlobalInvocationID.z < 6 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 5 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec3(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y,gl_GlobalInvocationID.z), ivec4(index % 127, index % 127, index % 127, 1));
    }
}
