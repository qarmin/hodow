#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(set = 0, binding = 0, r32f) readonly  uniform image3D srcImg;
layout(set = 0, binding = 1, r32f) writeonly uniform image3D dstImg;

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    for (int z = 0; z < 8; ++z)
    for (int y = 0; y < 64; ++y)
    for (int x = 0; x < 64; ++x)
        imageStore(dstImg, ivec3(x, y, z), imageLoad(srcImg, ivec3(x, y, z)));
}
