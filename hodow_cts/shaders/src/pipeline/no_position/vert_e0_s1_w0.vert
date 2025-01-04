#version 450
layout (set=0, binding=0, std430) buffer StorageBlock { uint counters[4]; } ssbo;
layout (location=0) in vec4 in_pos;
void main (void)
{
    atomicAdd(ssbo.counters[0], 1);
}
