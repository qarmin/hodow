#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r32f) readonly  uniform image3D srcImg;
layout(set = 0, binding = 1, r32f) writeonly uniform image3D dstImg;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int z = 0; z < 8; ++z)
    for (int y = 0; y < 64; ++y)
    for (int x = 0; x < 64; ++x)
        imageStore(dstImg, ivec3(x, y, z), imageLoad(srcImg, ivec3(x, y, z)));
}
