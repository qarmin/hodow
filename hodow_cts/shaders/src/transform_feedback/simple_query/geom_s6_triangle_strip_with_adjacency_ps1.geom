#version 450

layout(triangles_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 6, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(6);
    out0 = in0[1];
    EmitStreamVertex(6);
    out0 = in0[2];
    EmitStreamVertex(6);
    EndStreamPrimitive(6);
}
