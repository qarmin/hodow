#version 450

layout(binding = 0, rgba8) writeonly uniform image2D image;

void main(void)
{
    imageStore(image, ivec2(gl_PrimitiveID % 4, 0), vec4(1.0, 0.5, 0.25, 1.0));
}
