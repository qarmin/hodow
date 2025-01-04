#version 450
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
void main (void)
{
    for (int i = 0; i < 3; i++)
    {
        EmitVertex();
    }
}
