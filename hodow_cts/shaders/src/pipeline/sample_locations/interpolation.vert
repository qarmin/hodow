#version 450

layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec2 o_position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
    o_position  = in_position.xy;
}
