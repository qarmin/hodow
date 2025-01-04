#version 440
layout(location = 0) centroid in vec2 fs_in_pos_screen_centroid;
layout(location = 1)          in vec2 fs_in_pos_screen_fragment;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const float threshold = 0.0005;

    const vec2 position_a  = interpolateAtSample(fs_in_pos_screen_centroid, gl_SampleID);
    const vec2 position_b  = interpolateAtSample(fs_in_pos_screen_fragment, gl_SampleID);
    const bool valuesEqual = all(lessThan(abs(position_a - position_b), vec2(threshold)));

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
