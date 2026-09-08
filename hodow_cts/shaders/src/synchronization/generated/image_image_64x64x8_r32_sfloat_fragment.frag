#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, r32f) readonly  uniform image3D srcImg;
layout(set = 0, binding = 1, r32f) writeonly uniform image3D dstImg;

void main (void)
{
    o_color = vec4(1.0);

    for (int z = 0; z < 8; ++z)
    for (int y = 0; y < 64; ++y)
    for (int x = 0; x < 64; ++x)
        imageStore(dstImg, ivec3(x, y, z), imageLoad(srcImg, ivec3(x, y, z)));
}
