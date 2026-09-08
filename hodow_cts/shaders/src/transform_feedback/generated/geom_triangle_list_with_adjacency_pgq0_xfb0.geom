#version 450
layout(triangles_adjacency) in;
layout(triangle_strip, max_vertices = 3) out;
void main (void)
{
    EmitVertex();
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
