#version 450

layout(points) in;
layout(points, max_vertices = 1) out;
layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = 1.0;
    EmitVertex();
    EndPrimitive();
}
