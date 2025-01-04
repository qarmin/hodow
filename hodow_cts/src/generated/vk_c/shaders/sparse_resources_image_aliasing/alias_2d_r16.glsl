#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 512 )
    if( gl_GlobalInvocationID.y < 256 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 512 * logicalY + 512 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 503 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 503 * logicalY + 503 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 251 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 251 * logicalY + 251 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 125, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 125 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 125 * logicalY + 125 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 62, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 62 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 62 * logicalY + 62 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 31, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 31 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 31 * logicalY + 31 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 15, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 15 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 15 * logicalY + 15 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 7, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 7 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 7 * logicalY + 7 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 3, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 3 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 3 * logicalY + 3 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 37 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 37 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 18, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 18 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 18 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 9, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 9 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 9 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
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
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 512 * logicalY + 512 * 256 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 256 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 256 * logicalY + 256 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 128 )
    if( gl_GlobalInvocationID.y < 128 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 128 * logicalY + 128 * 128 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 64, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 64 )
    if( gl_GlobalInvocationID.y < 64 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 64 * logicalY + 64 * 64 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 32, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 32 )
    if( gl_GlobalInvocationID.y < 32 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 32 * logicalY + 32 * 32 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 16, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 16 )
    if( gl_GlobalInvocationID.y < 16 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 16 * logicalY + 16 * 16 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 8 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 8 * logicalY + 8 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 4, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 4 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 4 * logicalY + 4 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 503 )
    if( gl_GlobalInvocationID.y < 137 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 503 * logicalY + 503 * 137 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 128, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 251 )
    if( gl_GlobalInvocationID.y < 68 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 251 * logicalY + 251 * 68 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 125, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 125 )
    if( gl_GlobalInvocationID.y < 34 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 125 * logicalY + 125 * 34 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 62, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 62 )
    if( gl_GlobalInvocationID.y < 17 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 62 * logicalY + 62 * 17 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 31, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 31 )
    if( gl_GlobalInvocationID.y < 8 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 31 * logicalY + 31 * 8 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 15, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 15 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 15 * logicalY + 15 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 7, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 7 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 7 * logicalY + 7 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 3, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 3 )
    if( gl_GlobalInvocationID.y < 1 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 3 * logicalY + 3 * 1 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 11, local_size_y = 11, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 11 )
    if( gl_GlobalInvocationID.y < 37 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 11 * logicalY + 11 * 37 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 5, local_size_y = 18, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 5 )
    if( gl_GlobalInvocationID.y < 18 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 5 * logicalY + 5 * 18 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 2, local_size_y = 9, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 2 )
    if( gl_GlobalInvocationID.y < 9 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 2 * logicalY + 2 * 9 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 4, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 4 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 4 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
#version 440

layout (local_size_x = 1, local_size_y = 2, local_size_z = 1) in;
layout (binding = 0, r16_snorm) writeonly uniform highp image2D u_image;
void main (void)
{
    if( gl_GlobalInvocationID.x < 1 )
    if( gl_GlobalInvocationID.y < 2 )
    if( gl_GlobalInvocationID.z < 1 )
    {
        int logicalX = int(gl_GlobalInvocationID.x) * 1;
        int logicalY = int(gl_GlobalInvocationID.y) * 1;
        int index = logicalX + 1 * logicalY + 1 * 2 * int(gl_GlobalInvocationID.z);
        imageStore(u_image, ivec2(gl_GlobalInvocationID.x,gl_GlobalInvocationID.y), vec4(float(index % 127) / 127.0, float(index % 127) / 127.0, float(index % 127) / 127.0, 1.0));
    }
}
