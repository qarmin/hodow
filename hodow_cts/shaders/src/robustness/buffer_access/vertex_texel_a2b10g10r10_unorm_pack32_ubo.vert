#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(set = 0, binding = 0) uniform highp textureBuffer inImage;
layout(set = 0, binding = 1, rgb10_a2) uniform highp writeonly imageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    for (int i = 0; i < 16; i++)
    {
        imageStore(outImage, outOffset + i, texelFetch(inImage, inOffset + i));
    }
    gl_Position = position;
}
