#version 440
layout(location = 0) in vec4 fs_in_position_ndc;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const vec4 position_ndc_at_sample = interpolateAtSample(fs_in_position_ndc, gl_SampleID);
    if(position_ndc_at_sample.y < -2.0*pow(0.5*(position_ndc_at_sample.x + 1.0), 2.0) + 1.0)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
