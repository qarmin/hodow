#version 450
#extension GL_EXT_multiview : require
layout (set=0, binding=0, std430) buffer StorageBlock { uint counters[8]; } ssbo;
layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
    float gl_ClipDistance[];
    float gl_CullDistance[];
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
    float gl_ClipDistance[];
    float gl_CullDistance[];
};
void main (void)
{
    atomicAdd(ssbo.counters[2 * 2 + gl_ViewIndex], 1);
}
