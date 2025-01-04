#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    gl_Position = v_in_position;
}
