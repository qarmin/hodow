#version 450
out gl_PerVertex
 {
    vec4 gl_Position;
    float gl_PointSize;
};
layout(location = 0) in vec4 a_position;
void main (void)
{
    gl_Position = a_position;
}
