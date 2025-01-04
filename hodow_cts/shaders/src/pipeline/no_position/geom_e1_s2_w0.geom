#version 450
#extension GL_EXT_multiview : require
layout (set=0, binding=0, std430) buffer StorageBlock { uint counters[8]; } ssbo;
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
    float gl_ClipDistance[];
    float gl_CullDistance[];
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
    float gl_ClipDistance[];
    float gl_CullDistance[];
};
void main (void)
{
    for (int i = 0; i < 3; i++)
    {
        EmitVertex();
    }
    atomicAdd(ssbo.counters[3 * 2 + gl_ViewIndex], 1);
}
