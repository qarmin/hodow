#version 450

layout(location = 0) in vec4 v_position;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};

void main (void)
{
    gl_Position = v_position;
    gl_PointSize = 12.0;
}
