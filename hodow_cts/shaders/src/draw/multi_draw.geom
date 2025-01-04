#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
};

layout (location=0) in uvec4 inColor[3];
layout (location=0) out uvec4 outColor;

void main ()
{
    gl_Position = gl_in[0].gl_Position; outColor = inColor[0]; EmitVertex();
    gl_Position = gl_in[1].gl_Position; outColor = inColor[1]; EmitVertex();
    gl_Position = gl_in[2].gl_Position; outColor = inColor[2]; EmitVertex();
}
