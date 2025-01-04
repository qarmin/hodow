#version 450
#extension GL_EXT_multiview : enable
layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main()
{
    out_color = in_color + vec4(0.0, gl_ViewIndex * 0.10f, 0.0, 0.0);
}
