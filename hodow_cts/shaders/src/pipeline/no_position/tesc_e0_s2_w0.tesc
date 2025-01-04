#version 450
#extension GL_EXT_multiview : require
layout (set=0, binding=0, std430) buffer StorageBlock { uint counters[8]; } ssbo;
layout (vertices = 3) out;
void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    atomicAdd(ssbo.counters[1 * 2 + gl_ViewIndex], 1);
}
