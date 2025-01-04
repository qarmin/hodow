#version 450

layout(location = 0) in  vec4 in_position;
layout(location = 1) in  vec4 in_color;
layout(location = 0) out vec4 o_color;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
    o_color     = in_color;
}
