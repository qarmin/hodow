#version 450
layout (set=0, binding=0, std430) buffer StorageBlock { uint counters[4]; } ssbo;
layout (location=0) in vec4 in_pos;
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
    float gl_ClipDistance[];
    float gl_CullDistance[];
};
void main (void)
{
    gl_Position = in_pos;
    atomicAdd(ssbo.counters[0], 1);
}
