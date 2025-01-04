#version 450
layout (set=0, binding=0, std430) buffer StorageBlock { uint counters[4]; } ssbo;
layout (triangles, fractional_odd_spacing, cw) in;
void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    atomicAdd(ssbo.counters[2], 1);
}
