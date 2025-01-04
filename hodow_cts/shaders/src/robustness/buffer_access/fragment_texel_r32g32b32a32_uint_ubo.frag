#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(set = 0, binding = 0) uniform highp utextureBuffer inImage;
layout(set = 0, binding = 1, rgba32ui) uniform highp writeonly uimageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, texelFetch(inImage, inOffset + i));
    }
    fragColor = vec4(1.0);
}
