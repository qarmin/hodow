#version 430
#extension GL_ARB_enhanced_layouts : require

layout(location = 0) in InterfaceBlock {
    layout(location = 0) vec4 in_color_smooth;
    layout(location = 1) flat vec4 in_color_flat;
    layout(location = 2) noperspective vec4 in_color_noperspective;
    layout(location = 3) centroid vec4 in_color_centroid;
} ifb;

layout(push_constant, std430) uniform PushConstants {
    uint interpolationIndex;
} pc;

layout(location=0) out vec4 out_color;

void main()
{
    const vec4 in_colors[4] = vec4[](
        ifb.in_color_smooth,
        ifb.in_color_flat,
        ifb.in_color_noperspective,
        ifb.in_color_centroid
    );
    out_color = in_colors[pc.interpolationIndex];
}
