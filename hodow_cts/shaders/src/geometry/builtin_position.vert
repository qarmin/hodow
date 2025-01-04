#version 450
out gl_PerVertex
 {
    vec4 gl_Position;
    float gl_PointSize;
};
layout(location = 0) in vec4 a_position;
layout(location = 0) out vec4 v_position;
void main (void)
{
    v_position = a_position;
    gl_Position = a_position;
}
