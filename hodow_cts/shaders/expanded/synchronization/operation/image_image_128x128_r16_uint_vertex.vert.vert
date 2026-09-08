#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, r16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    gl_Position = v_in_position;
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
