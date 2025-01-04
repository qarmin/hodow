#version 440
layout(location = 0) in vec2 fs_in_position_screen;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const float threshold = 0.15625;
    const vec2  position_screen_at_sample = interpolateAtSample(fs_in_position_screen, 0);
    const vec2  position_inside_pixel = fract(position_screen_at_sample);

    if (abs(position_inside_pixel.x - 0.5) <= threshold && abs(position_inside_pixel.y - 0.5) <= threshold)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
