#version 450
#extension GL_EXT_multiview : require
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
}
