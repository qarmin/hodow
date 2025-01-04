#version 440

precision highp image1D;

layout (local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout (r32f, binding=0) coherent uniform image1D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, gx, vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/1*1;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 1;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, readX).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, gx, vec4(sum));
}
#version 440

precision highp uimage1D;

layout (local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage1D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, gx, uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/1*1;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 1;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, readX).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, gx, uvec4(sum));
}
#version 440

precision highp iimage1D;

layout (local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage1D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, gx, ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/1*1;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 1;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, readX).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, gx, ivec4(sum));
}
#version 440

precision highp image1DArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout (r32f, binding=0) coherent uniform image1DArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec2(gx,gy), vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, ivec2(readX,readY)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec2(gx,gy), vec4(sum));
}
#version 440

precision highp uimage1DArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage1DArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec2(gx,gy), uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, ivec2(readX,readY)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec2(gx,gy), uvec4(sum));
}
#version 440

precision highp iimage1DArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage1DArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec2(gx,gy), ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, ivec2(readX,readY)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec2(gx,gy), ivec4(sum));
}
#version 440

precision highp image2D;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout (r32f, binding=0) coherent uniform image2D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec2(gx,gy), vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, ivec2(readX,readY)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec2(gx,gy), vec4(sum));
}
#version 440

precision highp uimage2D;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimage2D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec2(gx,gy), uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, ivec2(readX,readY)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec2(gx,gy), uvec4(sum));
}
#version 440

precision highp iimage2D;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimage2D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec2(gx,gy), ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, ivec2(readX,readY)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec2(gx,gy), ivec4(sum));
}
#version 440

precision highp image2DArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32f, binding=0) coherent uniform image2DArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), vec4(sum));
}
#version 440

precision highp uimage2DArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32ui, binding=0) coherent uniform uimage2DArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), uvec4(sum));
}
#version 440

precision highp iimage2DArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32i, binding=0) coherent uniform iimage2DArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), ivec4(sum));
}
#version 440

precision highp image3D;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32f, binding=0) coherent uniform image3D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), vec4(sum));
}
#version 440

precision highp uimage3D;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32ui, binding=0) coherent uniform uimage3D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), uvec4(sum));
}
#version 440

precision highp iimage3D;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32i, binding=0) coherent uniform iimage3D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), ivec4(sum));
}
#version 440

precision highp imageCube;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32f, binding=0) coherent uniform imageCube u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), vec4(sum));
}
#version 440

precision highp uimageCube;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32ui, binding=0) coherent uniform uimageCube u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), uvec4(sum));
}
#version 440

precision highp iimageCube;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32i, binding=0) coherent uniform iimageCube u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), ivec4(sum));
}
#version 440

precision highp imageCubeArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32f, binding=0) coherent uniform imageCubeArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), vec4(sum));
}
#version 440

precision highp uimageCubeArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32ui, binding=0) coherent uniform uimageCubeArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), uvec4(sum));
}
#version 440

precision highp iimageCubeArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32i, binding=0) coherent uniform iimageCubeArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), ivec4(sum));
}
#version 440

precision highp imageBuffer;

layout (local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout (r32f, binding=0) coherent uniform imageBuffer u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, gx, vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/1*1;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 1;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, readX).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, gx, vec4(sum));
}
#version 440

precision highp uimageBuffer;

layout (local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) coherent uniform uimageBuffer u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, gx, uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/1*1;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 1;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, readX).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, gx, uvec4(sum));
}
#version 440

precision highp iimageBuffer;

layout (local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) coherent uniform iimageBuffer u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, gx, ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/1*1;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 1;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, readX).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, gx, ivec4(sum));
}
#version 440

precision highp image1D;

layout (local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout (r32f, binding=0) volatile uniform image1D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, gx, vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/1*1;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 1;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, readX).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, gx, vec4(sum));
}
#version 440

precision highp uimage1D;

layout (local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) volatile uniform uimage1D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, gx, uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/1*1;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 1;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, readX).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, gx, uvec4(sum));
}
#version 440

precision highp iimage1D;

layout (local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) volatile uniform iimage1D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, gx, ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/1*1;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 1;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, readX).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, gx, ivec4(sum));
}
#version 440

precision highp image1DArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout (r32f, binding=0) volatile uniform image1DArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec2(gx,gy), vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, ivec2(readX,readY)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec2(gx,gy), vec4(sum));
}
#version 440

precision highp uimage1DArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout (r32ui, binding=0) volatile uniform uimage1DArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec2(gx,gy), uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, ivec2(readX,readY)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec2(gx,gy), uvec4(sum));
}
#version 440

precision highp iimage1DArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout (r32i, binding=0) volatile uniform iimage1DArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec2(gx,gy), ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, ivec2(readX,readY)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec2(gx,gy), ivec4(sum));
}
#version 440

precision highp image2D;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout (r32f, binding=0) volatile uniform image2D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec2(gx,gy), vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, ivec2(readX,readY)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec2(gx,gy), vec4(sum));
}
#version 440

precision highp uimage2D;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout (r32ui, binding=0) volatile uniform uimage2D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec2(gx,gy), uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, ivec2(readX,readY)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec2(gx,gy), uvec4(sum));
}
#version 440

precision highp iimage2D;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout (r32i, binding=0) volatile uniform iimage2D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec2(gx,gy), ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, ivec2(readX,readY)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec2(gx,gy), ivec4(sum));
}
#version 440

precision highp image2DArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32f, binding=0) volatile uniform image2DArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), vec4(sum));
}
#version 440

precision highp uimage2DArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32ui, binding=0) volatile uniform uimage2DArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), uvec4(sum));
}
#version 440

precision highp iimage2DArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32i, binding=0) volatile uniform iimage2DArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), ivec4(sum));
}
#version 440

precision highp image3D;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32f, binding=0) volatile uniform image3D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), vec4(sum));
}
#version 440

precision highp uimage3D;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32ui, binding=0) volatile uniform uimage3D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), uvec4(sum));
}
#version 440

precision highp iimage3D;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32i, binding=0) volatile uniform iimage3D u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), ivec4(sum));
}
#version 440

precision highp imageCube;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32f, binding=0) volatile uniform imageCube u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), vec4(sum));
}
#version 440

precision highp uimageCube;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32ui, binding=0) volatile uniform uimageCube u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), uvec4(sum));
}
#version 440

precision highp iimageCube;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32i, binding=0) volatile uniform iimageCube u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), ivec4(sum));
}
#version 440

precision highp imageCubeArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32f, binding=0) volatile uniform imageCubeArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), vec4(sum));
}
#version 440

precision highp uimageCubeArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32ui, binding=0) volatile uniform uimageCubeArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), uvec4(sum));
}
#version 440

precision highp iimageCubeArray;

layout (local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout (r32i, binding=0) volatile uniform iimageCubeArray u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, ivec3(gx,gy,gz), ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/8*8;
    int groupBaseZ = gz/2*2;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 8;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 2;
        sum += imageLoad(u_image, ivec3(readX,readY,readZ)).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, ivec3(gx,gy,gz), ivec4(sum));
}
#version 440

precision highp imageBuffer;

layout (local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout (r32f, binding=0) volatile uniform imageBuffer u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, gx, vec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    float sum = float(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/1*1;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 1;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, readX).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, gx, vec4(sum));
}
#version 440

precision highp uimageBuffer;

layout (local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout (r32ui, binding=0) volatile uniform uimageBuffer u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, gx, uvec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    uint sum = uint(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/1*1;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 1;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, readX).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, gx, uvec4(sum));
}
#version 440

precision highp iimageBuffer;

layout (local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout (r32i, binding=0) volatile uniform iimageBuffer u_image;
void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);
    imageStore(u_image, gx, ivec4(gx^gy^gz));

    memoryBarrier();
    barrier();

    int sum = int(0);
    int groupBaseX = gx/8*8;
    int groupBaseY = gy/1*1;
    int groupBaseZ = gz/1*1;
    int xOffsets[] = int[]( 1, 4, 7, 10 );
    int yOffsets[] = int[]( 2, 5, 8, 11 );
    int zOffsets[] = int[]( 3, 6, 9, 12 );
    for (int i = 0; i < 4; i++)
    {
        int readX = groupBaseX + (gx + xOffsets[i]) % 8;
        int readY = groupBaseY + (gy + yOffsets[i]) % 1;
        int readZ = groupBaseZ + (gz + zOffsets[i]) % 1;
        sum += imageLoad(u_image, readX).x;
    }

    memoryBarrier();
    barrier();

    imageStore(u_image, gx, ivec4(sum));
}
