#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r32ui) readonly  uniform uimage1D srcImg;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage1D dstImg;

void main (void)
{
    gl_Position = v_in_position;
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, x, imageLoad(srcImg, x));
}
