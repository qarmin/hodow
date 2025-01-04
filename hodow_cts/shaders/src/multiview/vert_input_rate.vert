#version 450
#extension GL_EXT_multiview : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main (void)
{
    int instance = gl_InstanceIndex + 1;
    gl_Position = in_position;
    if (gl_VertexIndex == 1)
        gl_Position.y += 1.0f;
    else if (gl_VertexIndex == 2)
        gl_Position.x += 1.0f;
    else if (gl_VertexIndex == 3)
    {
        gl_Position.x += 1.0f;
        gl_Position.y += 1.0f;
    }
    out_color = in_color + vec4(0.0f, gl_ViewIndex * 0.10f, instance * 0.10f, 0.0f);
}
