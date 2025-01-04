#version 450
#extension GL_EXT_multiview : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 1) in highp vec4 in_color;
layout(location = 0) out vec4 out_color;
void main (void)
{
    gl_Position = in_position;
    if (gl_ViewIndex == 0)
        gl_PointSize = 4.0f;
    else
        gl_PointSize = 2.0f;
    out_color = in_color;
}
