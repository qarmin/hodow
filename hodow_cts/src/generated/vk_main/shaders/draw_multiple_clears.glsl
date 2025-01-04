#version 450

layout(location = 0) in vec4 in_position;

out gl_PerVertex {
    vec4  gl_Position;
};

void main(void)
{
    gl_Position = in_position;
}
#version 450

layout(push_constant) uniform Color { vec4 color; } u_color;
layout(location = 0) out vec4 out_color;

void main(void)
{
    out_color = u_color.color;
}
#version 450

layout(push_constant) uniform Color { vec4 color; } u_color;

void main(void)
{
}
