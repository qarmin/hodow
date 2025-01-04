#version 450
layout (set=0, binding=0, std430) buffer StorageBlock { uint counters[4]; } ssbo;
layout (triangles, fractional_odd_spacing, cw) in;
void main (void)
{
    atomicAdd(ssbo.counters[2], 1);
}
