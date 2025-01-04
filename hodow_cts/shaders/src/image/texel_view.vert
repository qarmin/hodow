#version 450

layout(location = 0) in vec4 v_in_position;

void main (void)
{
    gl_Position = v_in_position;
}
