#version 450

layout(lines_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 1, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(1);
    out0 = in0[1];
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
