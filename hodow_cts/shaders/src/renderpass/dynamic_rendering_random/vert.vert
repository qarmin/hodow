#version 450

layout(location = 0) in vec4 position;
layout(location = 0) out vec4 vsColor;

layout( push_constant ) uniform constants
{
    vec4 scale;
    vec4 offset;
    vec4 color;
    int layer;
} pc;

void main (void)
{
    gl_Position = position * pc.scale + pc.offset;
    vsColor     = pc.color;
}
