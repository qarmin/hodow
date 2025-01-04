#version 450
#extension GL_EXT_multiview : require
layout (set=0, binding=0, std430) buffer StorageBlock { uint counters[8]; } ssbo;
layout (triangles, fractional_odd_spacing, cw) in;
void main (void)
{
    atomicAdd(ssbo.counters[2 * 2 + gl_ViewIndex], 1);
}
