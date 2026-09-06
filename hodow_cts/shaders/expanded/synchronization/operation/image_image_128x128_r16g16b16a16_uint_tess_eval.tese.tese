#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, rgba16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, rgba16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
