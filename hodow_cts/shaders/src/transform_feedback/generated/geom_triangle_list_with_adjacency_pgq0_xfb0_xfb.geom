#version 450
layout(triangles_adjacency) in;
layout(triangle_strip, max_vertices = 3) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0, stream = 0) out vec4 xfb;
void main (void)
{
    xfb = vec4(42);
    EmitVertex();
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
