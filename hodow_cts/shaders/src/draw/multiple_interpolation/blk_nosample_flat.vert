#version 430
#extension GL_ARB_enhanced_layouts : require

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out InterfaceBlock {
    layout(location = 0) flat vec4 out_color;
} ifb;

void main()
{
    ifb.out_color = in_color;
    gl_Position = in_position;
}
