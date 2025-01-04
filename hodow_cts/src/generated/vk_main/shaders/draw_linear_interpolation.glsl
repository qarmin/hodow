#version 450

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) out vec4 out_color;

void main()
{
    gl_PointSize = 1.0;
    gl_Position  = in_position;
    out_color    = in_color;
}
#version 450

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) noperspective out vec4 out_color;

void main()
{
    gl_PointSize = 1.0;
    gl_Position  = in_position;
    out_color    = in_color;
}
#version 450
layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main()
{
    vec4 out_color_y = mix(vec4(0.0, 1.0, 0.0, 1.0), vec4(1.0, 0.0, 0.0, 1.0), gl_FragCoord.y / 16 + 0);
    vec4 out_color_x = mix(vec4(1.0, 0.0, 0.0, 1.0), vec4(0.0, 1.0, 0.0, 1.0), gl_FragCoord.x / 16 + 0);
    out_color = 0.5 * (out_color_y + out_color_x);
}
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
#version 450
layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main()
{
    vec4 out_color_y = mix(vec4(0.0, 1.0, 0.0, 1.0), vec4(1.0, 0.0, 0.0, 1.0), gl_FragCoord.y / 16 + -0.03125);
    vec4 out_color_x = mix(vec4(1.0, 0.0, 0.0, 1.0), vec4(0.0, 1.0, 0.0, 1.0), gl_FragCoord.x / 16 + -0.03125);
    out_color = 0.5 * (out_color_y + out_color_x);
}
#version 450
layout(location = 0) noperspective in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main()
{
    vec4 out_color_offset = interpolateAtOffset(in_color, vec2(-0.5, -0.5));
    vec4 out_color_sample = interpolateAtSample(in_color, gl_SampleID);
    out_color = (0.5 * (out_color_offset + out_color_sample));
    out_color /= 1;
    vec4 diff = out_color_sample - interpolateAtOffset(in_color, gl_SamplePosition - vec2(0.5));    float min_precision = 0.000001;
    if (diff.x > min_precision && diff.y > min_precision && diff.z > min_precision && diff.w > min_precision)
    {
        out_color.z = 1.0;
    }
}
#version 450
layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main()
{
    vec4 out_color_y = mix(vec4(0.0, 1.0, 0.0, 1.0), vec4(1.0, 0.0, 0.0, 1.0), gl_FragCoord.y / 16 + 0.0273438);
    vec4 out_color_x = mix(vec4(1.0, 0.0, 0.0, 1.0), vec4(0.0, 1.0, 0.0, 1.0), gl_FragCoord.x / 16 + 0.0273438);
    out_color = 0.5 * (out_color_y + out_color_x);
}
#version 450
layout(location = 0) noperspective in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main()
{
    vec4 out_color_offset = interpolateAtOffset(in_color, vec2(0.4375, 0.4375));
    vec4 out_color_sample = interpolateAtSample(in_color, gl_SampleID);
    out_color = (0.5 * (out_color_offset + out_color_sample));
    out_color /= 1;
    vec4 diff = out_color_sample - interpolateAtOffset(in_color, gl_SamplePosition - vec2(0.5));    float min_precision = 0.000001;
    if (diff.x > min_precision && diff.y > min_precision && diff.z > min_precision && diff.w > min_precision)
    {
        out_color.z = 1.0;
    }
}
