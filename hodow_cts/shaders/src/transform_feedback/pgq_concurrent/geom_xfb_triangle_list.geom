#version 450
layout(triangles) in;
layout(points, max_vertices = 2) out;
layout(xfb_buffer = 1, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 1) out vec4 xfb;
void main (void)
{
    xfb = vec4(42);
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
