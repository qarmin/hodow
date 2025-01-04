#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r32f) readonly  uniform image3D srcImg;
layout(set = 0, binding = 1, r32f) writeonly uniform image3D dstImg;

void main (void)
{
    gl_Position = v_in_position;
    for (int z = 0; z < 8; ++z)
    for (int y = 0; y < 64; ++y)
    for (int x = 0; x < 64; ++x)
        imageStore(dstImg, ivec3(x, y, z), imageLoad(srcImg, ivec3(x, y, z)));
}
