#version 440

layout(location = 0) in highp vec4 a_position;
layout(location = 0) out highp vec4 a_color;

void main (void)
{
    gl_Position = a_position;
    if (gl_VertexIndex < 3)
        a_color = vec4(0.00f, 0.00f, 1.00f, 1.0f);
    else
        a_color = vec4(0.00f, 1.00f, 0.00f, 1.0f);
}
