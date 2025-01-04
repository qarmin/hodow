#version 430

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out vec4 out_color_smooth;
layout(location = 1) out flat vec4 out_color_flat;
layout(location = 2) out noperspective vec4 out_color_noperspective;
layout(location = 3) out centroid vec4 out_color_centroid;

void main()
{
    out_color_smooth = in_color;
    out_color_flat = in_color;
    out_color_noperspective = in_color;
    out_color_centroid = in_color;
    gl_Position = in_position;
}
#version 430

layout(location = 0) in vec4 in_color_smooth;
layout(location = 1) in flat vec4 in_color_flat;
layout(location = 2) in noperspective vec4 in_color_noperspective;
layout(location = 3) in centroid vec4 in_color_centroid;

layout(push_constant, std430) uniform PushConstants {
    uint interpolationIndex;
} pc;

layout(location=0) out vec4 out_color;

void main()
{
    const vec4 in_colors[4] = vec4[](
        in_color_smooth,
        in_color_flat,
        in_color_noperspective,
        in_color_centroid
    );
    out_color = in_colors[pc.interpolationIndex];
}
#version 430

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out vec4 out_color;

void main()
{
    out_color = in_color;
    gl_Position = in_position;
}
#version 430

layout(location = 0) in vec4 in_color;

layout(location = 0) out vec4 out_color;

void main()
{
    out_color = in_color;
}
#version 430

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out flat vec4 out_color;

void main()
{
    out_color = in_color;
    gl_Position = in_position;
}
#version 430

layout(location = 0) in flat vec4 in_color;

layout(location = 0) out vec4 out_color;

void main()
{
    out_color = in_color;
}
#version 430

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out noperspective vec4 out_color;

void main()
{
    out_color = in_color;
    gl_Position = in_position;
}
#version 430

layout(location = 0) in noperspective vec4 in_color;

layout(location = 0) out vec4 out_color;

void main()
{
    out_color = in_color;
}
#version 430

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out centroid vec4 out_color;

void main()
{
    out_color = in_color;
    gl_Position = in_position;
}
#version 430

layout(location = 0) in centroid vec4 in_color;

layout(location = 0) out vec4 out_color;

void main()
{
    out_color = in_color;
}
#version 430

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out vec4 out_color_smooth;
layout(location = 1) out flat vec4 out_color_flat;
layout(location = 2) out noperspective vec4 out_color_noperspective;
layout(location = 3) out centroid vec4 out_color_centroid;
layout(location = 4) out sample vec4 out_color_sample;

void main()
{
    out_color_smooth = in_color;
    out_color_flat = in_color;
    out_color_noperspective = in_color;
    out_color_centroid = in_color;
    out_color_sample = in_color;
    gl_Position = in_position;
}
#version 430

layout(location = 0) in vec4 in_color_smooth;
layout(location = 1) in flat vec4 in_color_flat;
layout(location = 2) in noperspective vec4 in_color_noperspective;
layout(location = 3) in centroid vec4 in_color_centroid;
layout(location = 4) in sample vec4 in_color_sample;

layout(push_constant, std430) uniform PushConstants {
    uint interpolationIndex;
} pc;

layout(location=0) out vec4 out_color;

void main()
{
    const vec4 in_colors[5] = vec4[](
        in_color_smooth,
        in_color_flat,
        in_color_noperspective,
        in_color_centroid,
        in_color_sample
    );
    out_color = in_colors[pc.interpolationIndex];
}
#version 430

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out sample vec4 out_color;

void main()
{
    out_color = in_color;
    gl_Position = in_position;
}
#version 430

layout(location = 0) in sample vec4 in_color;

layout(location = 0) out vec4 out_color;

void main()
{
    out_color = in_color;
}
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
#version 430
#extension GL_ARB_enhanced_layouts : require

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out InterfaceBlock {
    layout(location = 0) vec4 out_color;
} ifb;

void main()
{
    ifb.out_color = in_color;
    gl_Position = in_position;
}
#version 430
#extension GL_ARB_enhanced_layouts : require

layout(location = 0) in InterfaceBlock {
    layout(location = 0) vec4 in_color;
} ifb;

layout(location = 0) out vec4 out_color;

void main()
{
    out_color = ifb.in_color;
}
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
#version 430
#extension GL_ARB_enhanced_layouts : require

layout(location = 0) in InterfaceBlock {
    layout(location = 0) flat vec4 in_color;
} ifb;

layout(location = 0) out vec4 out_color;

void main()
{
    out_color = ifb.in_color;
}
#version 430
#extension GL_ARB_enhanced_layouts : require

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out InterfaceBlock {
    layout(location = 0) noperspective vec4 out_color;
} ifb;

void main()
{
    ifb.out_color = in_color;
    gl_Position = in_position;
}
#version 430
#extension GL_ARB_enhanced_layouts : require

layout(location = 0) in InterfaceBlock {
    layout(location = 0) noperspective vec4 in_color;
} ifb;

layout(location = 0) out vec4 out_color;

void main()
{
    out_color = ifb.in_color;
}
#version 430
#extension GL_ARB_enhanced_layouts : require

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out InterfaceBlock {
    layout(location = 0) centroid vec4 out_color;
} ifb;

void main()
{
    ifb.out_color = in_color;
    gl_Position = in_position;
}
#version 430
#extension GL_ARB_enhanced_layouts : require

layout(location = 0) in InterfaceBlock {
    layout(location = 0) centroid vec4 in_color;
} ifb;

layout(location = 0) out vec4 out_color;

void main()
{
    out_color = ifb.in_color;
}
#version 430
#extension GL_ARB_enhanced_layouts : require

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out InterfaceBlock {
    layout(location = 0) vec4 out_color_smooth;
    layout(location = 1) flat vec4 out_color_flat;
    layout(location = 2) noperspective vec4 out_color_noperspective;
    layout(location = 3) centroid vec4 out_color_centroid;
    layout(location = 4) sample vec4 out_color_sample;
} ifb;

void main()
{
    ifb.out_color_smooth = in_color;
    ifb.out_color_flat = in_color;
    ifb.out_color_noperspective = in_color;
    ifb.out_color_centroid = in_color;
    ifb.out_color_sample = in_color;
    gl_Position = in_position;
}
#version 430
#extension GL_ARB_enhanced_layouts : require

layout(location = 0) in InterfaceBlock {
    layout(location = 0) vec4 in_color_smooth;
    layout(location = 1) flat vec4 in_color_flat;
    layout(location = 2) noperspective vec4 in_color_noperspective;
    layout(location = 3) centroid vec4 in_color_centroid;
    layout(location = 4) sample vec4 in_color_sample;
} ifb;

layout(push_constant, std430) uniform PushConstants {
    uint interpolationIndex;
} pc;

layout(location=0) out vec4 out_color;

void main()
{
    const vec4 in_colors[5] = vec4[](
        ifb.in_color_smooth,
        ifb.in_color_flat,
        ifb.in_color_noperspective,
        ifb.in_color_centroid,
        ifb.in_color_sample
    );
    out_color = in_colors[pc.interpolationIndex];
}
#version 430
#extension GL_ARB_enhanced_layouts : require

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out InterfaceBlock {
    layout(location = 0) sample vec4 out_color;
} ifb;

void main()
{
    ifb.out_color = in_color;
    gl_Position = in_position;
}
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
