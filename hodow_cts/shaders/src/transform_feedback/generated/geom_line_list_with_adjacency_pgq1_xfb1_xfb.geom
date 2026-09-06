#version 450
layout(lines_adjacency) in;
layout(points, max_vertices = 1) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    gl_PointSize = 1.0;
    xfb = vec4(42);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
