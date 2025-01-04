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
