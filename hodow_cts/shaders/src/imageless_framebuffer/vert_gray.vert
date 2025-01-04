#version 440

layout(location = 0) in highp vec4 a_position;
layout(location = 0) out highp vec4 a_color;

void main (void)
{
    gl_Position = a_position;
    if (gl_VertexIndex < 6)
        a_color = vec4(0.75f, 0.75f, 0.75f, 1.0f);
    else
        a_color = vec4(1.00f, 1.00f, 1.00f, 1.0f);
}
