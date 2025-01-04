#version 450

layout(points) in;

layout(points, max_vertices = 2) out;

layout(location=0) in uint id[1];layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0, component = 0) out uint out0;
layout(stream = 14, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 4, location = 0, component = 1) out uint out1;

out gl_PerVertex { float gl_PointSize; };

void main(void)
{
    out0 = id[0] * 2 + 0;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);

    out1 = id[0] * 2 + 1;
    gl_PointSize = 1.0;
    EmitStreamVertex(14);
    EndStreamPrimitive(14);
}
