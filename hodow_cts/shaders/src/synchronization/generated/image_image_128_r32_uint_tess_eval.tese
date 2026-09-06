#version 440

layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r32ui) readonly  uniform uimage1D srcImg;
layout(set = 0, binding = 1, r32ui) writeonly uniform uimage1D dstImg;

void main (void)
{
    vec3 px = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 py = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 pz = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(px + py + pz, 1.0);
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, x, imageLoad(srcImg, x));
}
