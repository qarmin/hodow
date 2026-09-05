#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, r32ui) readonly  uniform uimage1D srcImg;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage1D dstImg;

void main (void)
{
    o_color = vec4(1.0);

    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, x, imageLoad(srcImg, x));
}
