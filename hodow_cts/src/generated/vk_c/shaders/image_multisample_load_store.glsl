#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMS u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMSArray u_msImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec3(gx, gy, gz), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMSArray u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2DArray u_checksumImage;

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = int(gl_GlobalInvocationID.z);

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec3(gx, gy, gz), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec3(gx, gy, gz), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32f) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32ui) readonly  uniform uimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        uvec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == uvec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba16i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) writeonly uniform iimage2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, r32i) readonly  uniform iimage2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        ivec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        if (color == ivec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), 0, 0, 1))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581);
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1));
    }
}
#version 450

layout(local_size_x = 1) in;
layout(set = 0, binding = 1, rgba8_snorm) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31), (31-gx)^gy^gz, gx^(31-gy)^gz, (31-gx)^(31-gy)^gz)*0.0645161 + float(-1)));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 2; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 4; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 8; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 16; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 32; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) writeonly uniform image2DMS u_msImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        imageStore(u_msImage, ivec2(gx, gy), sampleNdx, vec4((31-gx)^(31-gy)^gz, (31-gx)^gy^gz, gx^(31-gy)^gz, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581);
    }
}
#version 450
#extension GL_EXT_shader_image_load_formatted : require
layout(local_size_x = 1) in;
layout(set = 0, binding = 1) readonly  uniform image2DMS u_msImage;
layout(set = 0, binding = 2, r32i) writeonly uniform iimage2D u_checksumImage;
layout(set = 0, binding = 0) readonly uniform Constants {
    int u_layerNdx;
};

void main (void)
{
    int gx = int(gl_GlobalInvocationID.x);
    int gy = int(gl_GlobalInvocationID.y);
    int gz = u_layerNdx;

    int checksum = 0;
    for (int sampleNdx = 0; sampleNdx < 64; ++sampleNdx) {
        vec4 color = imageLoad(u_msImage, ivec2(gx, gy), sampleNdx);
        vec4 diff  = abs(abs(color) - abs(vec4(0, 0, 0, gx^gy^gz^(sampleNdx >> 5)^(sampleNdx & 31))*0.0322581));
        if (all(lessThan(diff, vec4(0.02))))
            ++checksum;
    }

    imageStore(u_checksumImage, ivec2(gx, gy), ivec4(checksum));
}
