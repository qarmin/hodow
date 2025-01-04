#version 440
layout(location = 0) sample in vec2 fs_in_position_screen;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const float threshold = 0.15625; // 4 subpixel bits. Assume 3 accurate bits + 0.03125 for other errors
    const ivec2 nearby_pixel = ivec2(floor(fs_in_position_screen));
    bool ok = false;

    // sample at edge + inaccuaries may cause us to round to any neighboring pixel
    // check all neighbors for any match
    for (int dy = -1; dy <= 1; ++dy)
    for (int dx = -1; dx <= 1; ++dx)
    {
        ivec2 current_pixel = nearby_pixel + ivec2(dx, dy);
        vec2 position_inside_pixel = vec2(current_pixel) + gl_SamplePosition;
        vec2 position_diff = abs(position_inside_pixel - fs_in_position_screen);

        if (all(lessThan(position_diff, vec2(threshold))))
            ok = true;
    }

    if (ok)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
