#version 440
layout(location = 0) sample   in vec2 fs_in_pos_screen_sample[2];
layout(location = 2) centroid in vec2 fs_in_pos_screen_centroid[2];

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const float threshold = 0.0005;

    const float pos_interpolated_at_centroid = interpolateAtCentroid(fs_in_pos_screen_sample[1][1]);
    const bool  valuesEqual                  = (abs(pos_interpolated_at_centroid - fs_in_pos_screen_centroid[1][1]) < threshold);

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
