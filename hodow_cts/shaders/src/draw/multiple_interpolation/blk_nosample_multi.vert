#version 430
#extension GL_ARB_enhanced_layouts : require

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out InterfaceBlock {
    layout(location = 0) vec4 out_color_smooth;
    layout(location = 1) flat vec4 out_color_flat;
    layout(location = 2) noperspective vec4 out_color_noperspective;
    layout(location = 3) centroid vec4 out_color_centroid;
} ifb;

void main()
{
    ifb.out_color_smooth = in_color;
    ifb.out_color_flat = in_color;
    ifb.out_color_noperspective = in_color;
    ifb.out_color_centroid = in_color;
    gl_Position = in_position;
}
