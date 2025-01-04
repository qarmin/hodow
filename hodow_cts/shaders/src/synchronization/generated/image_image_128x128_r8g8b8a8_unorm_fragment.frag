#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, rgba8) readonly  uniform image2D srcImg;
layout(set = 0, binding = 1, rgba8) writeonly uniform image2D dstImg;

void main (void)
{
    o_color = vec4(1.0);

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
