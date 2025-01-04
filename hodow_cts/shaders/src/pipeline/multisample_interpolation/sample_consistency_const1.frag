#version 440
layout(location = 0) centroid in vec2 fs_in_pos_screen_centroid;
layout(location = 1) sample   in vec2 fs_in_pos_screen_sample;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const float threshold = 0.15625;

    const float pos_interpolated_at_sample = interpolateAtSample(fs_in_pos_screen_centroid[1], gl_SampleID);
    const bool  valuesEqual                = (abs(pos_interpolated_at_sample - fs_in_pos_screen_sample[1]) < threshold);

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
