#version 450
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
}
