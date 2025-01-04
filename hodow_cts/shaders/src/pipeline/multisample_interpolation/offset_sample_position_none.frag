#version 440
layout(location = 0)        in vec2 fs_in_pos_screen_fragment;
layout(location = 1) sample in vec2 fs_in_pos_screen_sample;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const float threshold = 0.15625;

    const vec2 offset                     = gl_SamplePosition - vec2(0.5, 0.5);
    const vec2 pos_interpolated_at_offset = interpolateAtOffset(fs_in_pos_screen_fragment, offset);
    const bool valuesEqual                = all(lessThan(abs(pos_interpolated_at_offset - fs_in_pos_screen_sample), vec2(threshold)));

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
