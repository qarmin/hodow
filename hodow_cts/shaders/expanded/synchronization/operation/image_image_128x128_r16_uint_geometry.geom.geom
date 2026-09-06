#version 440

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, r16ui) readonly  uniform uimage2D srcImg;
layout(set = 0, binding = 1, r16ui) writeonly uniform uimage2D dstImg;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    for (int y = 0; y < 128; ++y)
    for (int x = 0; x < 128; ++x)
        imageStore(dstImg, ivec2(x, y), imageLoad(srcImg, ivec2(x, y)));
}
