#version 450
#extension GL_EXT_multiview : require
layout (set=0, binding=0, std430) buffer StorageBlock { uint counters[8]; } ssbo;
layout (location=0) in vec4 in_pos;
void main (void)
{
    gl_Position = in_pos;
    atomicAdd(ssbo.counters[0 * 2 + gl_ViewIndex], 1);
}
