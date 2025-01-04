#version 430
#extension GL_ARB_enhanced_layouts : require

layout(location = 0) in InterfaceBlock {
    layout(location = 0) sample vec4 in_color;
} ifb;

layout(location = 0) out vec4 out_color;

void main()
{
    out_color = ifb.in_color;
}
