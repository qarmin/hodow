#version 450
layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) flat out vec4 out_color;

void main()
{
    
    out_color = in_color;
    gl_Position = in_position;
}
#version 450
layout(location = 0) flat in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main()
{
    out_color = in_color;
}
#version 450
layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) flat out vec4 out_color;
layout(xfb_buffer = 0, xfb_offset = 0, location = 1) out vec4 out_xfb;
void main()
{
    out_xfb = in_position;
    out_color = in_color;
    gl_Position = in_position;
}
