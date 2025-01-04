#version 450
layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) flat out vec4 out_color;
${xfb_decl}
void main()
{
    ${xfb_write}
    out_color = in_color;
    gl_Position = in_position;
}
