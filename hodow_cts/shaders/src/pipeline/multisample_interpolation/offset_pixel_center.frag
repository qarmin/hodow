#version 440
layout(location = 0) in  vec2 fs_in_pos_screen;
layout(location = 1) in  vec2 fs_in_offset;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const vec2  frag_center = interpolateAtOffset(fs_in_pos_screen, vec2(0.0));
    const vec2  center_diff = abs(frag_center - fs_in_pos_screen);
    const float threshold   = 0.125;
    bool        valuesEqual = false;

    if (all(lessThan(center_diff, vec2(0.5 + threshold)))) {
        const vec2 pos_interpolated_at_offset = interpolateAtOffset(fs_in_pos_screen, fs_in_offset);
        const vec2 reference_value            = frag_center + fs_in_offset;

        valuesEqual = all(lessThan(abs(pos_interpolated_at_offset - reference_value), vec2(threshold)));
    }

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
