#version 450
layout (location = 0) in vec2 texCoord;
layout (binding = 0, r32f) uniform image2D storageImage;
void main()
{
    ivec2 coord = ivec2(texCoord * 128.0f);
    vec4 color = vec4(coord.x + coord.y);
    imageStore(storageImage, coord, color);
}
