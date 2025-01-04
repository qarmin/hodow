#version 440
layout(location = 0) sample in vec4 fs_in_position_ndc;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    if(fs_in_position_ndc.y < -2.0*pow(0.5*(fs_in_position_ndc.x + 1.0), 2.0) + 1.0)
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
    else
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
}
