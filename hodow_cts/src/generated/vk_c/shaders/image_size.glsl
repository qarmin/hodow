#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform highp image1D u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0, 0);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform highp image1D u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0, 0);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly writeonly uniform highp image1D u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0, 0);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform highp image1DArray u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform highp image1DArray u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly writeonly uniform highp image1DArray u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform highp image2D u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform highp image2D u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly writeonly uniform highp image2D u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform highp image2DArray u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = imageSize(u_image);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform highp image2DArray u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = imageSize(u_image);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly writeonly uniform highp image2DArray u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = imageSize(u_image);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform highp image3D u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = imageSize(u_image);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform highp image3D u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = imageSize(u_image);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly writeonly uniform highp image3D u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = imageSize(u_image);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform highp imageCube u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform highp imageCube u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly writeonly uniform highp imageCube u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform highp imageCubeArray u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = imageSize(u_image);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform highp imageCubeArray u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = imageSize(u_image);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly writeonly uniform highp imageCubeArray u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = imageSize(u_image);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly uniform highp imageBuffer u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0, 0);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) writeonly uniform highp imageBuffer u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0, 0);
}
#version 440

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (binding = 0, rgba32f) readonly writeonly uniform highp imageBuffer u_image;
layout (binding = 1) writeonly buffer Output {
    ivec3 size;
} sb_out;

void main (void)
{
    sb_out.size = ivec3(imageSize(u_image), 0, 0);
}
