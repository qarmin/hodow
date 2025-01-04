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
