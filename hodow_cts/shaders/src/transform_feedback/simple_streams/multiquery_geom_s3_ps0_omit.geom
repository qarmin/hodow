#version 450

layout(points) in;

layout(points, max_vertices = 4) out;

layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(stream = 3, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 1) out vec4 out1;

void main(void)
{
    const int   n0 = 3;
    const int   n1 = 1;
    const float c0 = 0.5f;
    const float c1 = 0.5f + float(3);

    for (int j = 0; j < n0; j++)
    {
        EmitStreamVertex(0);
        EndStreamPrimitive(0);
    }

    for (int j = 0; j < n1; j++)
    {
        out1 = vec4(c1);
        EmitStreamVertex(3);
        EndStreamPrimitive(3);
    }
}
