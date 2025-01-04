#version 450
layout(location = 0) in highp vec4 a_position;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    }
