#version 450
layout(location = 0) noperspective in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main()
{
    vec4 out_color_offset = interpolateAtOffset(in_color, vec2(0, 0));
    vec4 out_color_sample = interpolateAtSample(in_color, gl_SampleID);
    out_color = (0.5 * (out_color_offset + out_color_sample));
    out_color /= 1;
    vec4 diff = out_color_sample - interpolateAtOffset(in_color, gl_SamplePosition - vec2(0.5));    float min_precision = 0.000001;
    if (diff.x > min_precision && diff.y > min_precision && diff.z > min_precision && diff.w > min_precision)
    {
        out_color.z = 1.0;
    }
}
