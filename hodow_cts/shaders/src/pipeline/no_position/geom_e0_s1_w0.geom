#version 450
layout (set=0, binding=0, std430) buffer StorageBlock { uint counters[4]; } ssbo;
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
void main (void)
{
    for (int i = 0; i < 3; i++)
    {
        EmitVertex();
    }
    atomicAdd(ssbo.counters[3], 1);
}
