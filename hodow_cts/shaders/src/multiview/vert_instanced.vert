#version 450
#extension GL_EXT_multiview : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main (void)
{
    int modInstance = gl_InstanceIndex % 4;
    int instance    = gl_InstanceIndex + 1;
    gl_Position = in_position;
    if (modInstance == 1)
        gl_Position = in_position + vec4(0.0f, 1.0f, 0.0f, 0.0f);
    if (modInstance == 2)
        gl_Position = in_position + vec4(1.0f, 0.0f, 0.0f, 0.0f);
    if (modInstance == 3)
        gl_Position =  in_position + vec4(1.0f, 1.0f, 0.0f, 0.0f);
    out_color = in_color + vec4(0.0f, gl_ViewIndex * 0.10f, instance * 0.10f, 0.0f);
}
