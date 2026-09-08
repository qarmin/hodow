#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(set = 0, binding = 0, r32ui) readonly  uniform uimage1D srcImg;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage1D dstImg;

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, x, imageLoad(srcImg, x));
}
