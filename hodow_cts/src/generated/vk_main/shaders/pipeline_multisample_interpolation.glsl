#version 440
layout(location = 0) in vec4 vs_in_position_ndc;

layout(location = 0) out vec4 vs_out_position_ndc;

out gl_PerVertex {
    vec4  gl_Position;
};
void main (void)
{
    gl_Position = vs_in_position_ndc;
    vs_out_position_ndc = vs_in_position_ndc;
}
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
#version 440
layout(location = 0) in vec4 vs_in_position_ndc;
layout(location = 1) in vec2 vs_in_position_screen;

layout(location = 0) out vec2 vs_out_position_screen;

out gl_PerVertex {
    vec4  gl_Position;
};
void main (void)
{
    gl_Position = vs_in_position_ndc;
    vs_out_position_screen = vs_in_position_screen;
}
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
#version 440
layout(location = 0) in vec4 vs_in_position_ndc;
layout(location = 1) in vec2 vs_in_position_screen;

layout(location = 0) out vec2 vs_out_pos_screen_centroid;
layout(location = 1) out vec2 vs_out_pos_screen_fragment;

out gl_PerVertex {
    vec4  gl_Position;
};
void main (void)
{
    gl_Position = vs_in_position_ndc;
    vs_out_pos_screen_centroid = vs_in_position_screen;
    vs_out_pos_screen_fragment = vs_in_position_screen;
}
#version 440
layout(location = 0) centroid in vec2 fs_in_pos_screen_centroid;
layout(location = 1)          in vec2 fs_in_pos_screen_fragment;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const float threshold = 0.0005;

    const vec2 position_a  = interpolateAtSample(fs_in_pos_screen_centroid, gl_SampleID);
    const vec2 position_b  = interpolateAtSample(fs_in_pos_screen_fragment, gl_SampleID);
    const bool valuesEqual = all(lessThan(abs(position_a - position_b), vec2(threshold)));

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 440
layout(location = 0) in vec4 vs_in_position_ndc;
layout(location = 1) in vec2 vs_in_position_screen;

layout(location = 0) out vec2 vs_out_pos_screen_centroid;
layout(location = 1) out vec2 vs_out_pos_screen_sample;

out gl_PerVertex {
    vec4  gl_Position;
};
void main (void)
{
    gl_Position = vs_in_position_ndc;
    vs_out_pos_screen_centroid = vs_in_position_screen;
    vs_out_pos_screen_sample = vs_in_position_screen;
}
#version 440
layout(location = 0) centroid in vec2 fs_in_pos_screen_centroid;
layout(location = 1) sample   in vec2 fs_in_pos_screen_sample;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const float threshold = 0.15625;

    const vec2  pos_interpolated_at_sample = interpolateAtSample(fs_in_pos_screen_centroid, gl_SampleID);
    const bool  valuesEqual                = all(lessThan(abs(pos_interpolated_at_sample - fs_in_pos_screen_sample), vec2(threshold)));

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 440
layout(location = 0) in vec4 vs_in_position_ndc;
layout(location = 1) in vec2 vs_in_position_screen;

layout(location = 0) out vec2 vs_out_pos_screen_sample[2];
layout(location = 2) out vec2 vs_out_pos_screen_centroid[2];

out gl_PerVertex {
    vec4  gl_Position;
};
void main (void)
{
    gl_Position                      = vs_in_position_ndc;
    vs_out_pos_screen_sample[0]      = vec2(-70.3, 42.1);
    vs_out_pos_screen_centroid[0] = vec2(7.7, -3.2);
    vs_out_pos_screen_sample[1]      = vs_in_position_screen;
    vs_out_pos_screen_centroid[1] = vs_in_position_screen;
}
#version 440
layout(location = 0) sample   in vec2 fs_in_pos_screen_sample[2];
layout(location = 2) centroid in vec2 fs_in_pos_screen_centroid[2];

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const float threshold = 0.0005;

    const vec2 pos_interpolated_at_centroid = interpolateAtCentroid(fs_in_pos_screen_sample[1]);
    const bool valuesEqual                  = all(lessThan(abs(pos_interpolated_at_centroid - fs_in_pos_screen_centroid[1]), vec2(threshold)));

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 440
layout(location = 0) in vec4 vs_in_position_ndc;
layout(location = 1) in vec2 vs_in_position_screen;

layout(location = 0) out vec2 vs_out_pos_screen_fragment;
layout(location = 1) out vec2 vs_out_pos_screen_sample;

out gl_PerVertex {
    vec4  gl_Position;
};
void main (void)
{
    gl_Position = vs_in_position_ndc;
    vs_out_pos_screen_fragment = vs_in_position_screen;
    vs_out_pos_screen_sample = vs_in_position_screen;
}
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
#version 440
layout(location = 0) centroid in vec2 fs_in_pos_screen_centroid;
layout(location = 1) sample   in vec2 fs_in_pos_screen_sample;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const float threshold = 0.15625;

    const float pos_interpolated_at_sample = interpolateAtSample(fs_in_pos_screen_centroid[0], gl_SampleID);
    const bool  valuesEqual                = (abs(pos_interpolated_at_sample - fs_in_pos_screen_sample[0]) < threshold);

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 440
layout(location = 0) sample   in vec2 fs_in_pos_screen_sample[2];
layout(location = 2) centroid in vec2 fs_in_pos_screen_centroid[2];

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const float threshold = 0.0005;

    const float pos_interpolated_at_centroid = interpolateAtCentroid(fs_in_pos_screen_sample[1][0]);
    const bool  valuesEqual                  = (abs(pos_interpolated_at_centroid - fs_in_pos_screen_centroid[1][0]) < threshold);

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 440
layout(location = 0)        in vec2 fs_in_pos_screen_fragment;
layout(location = 1) sample in vec2 fs_in_pos_screen_sample;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const float threshold = 0.15625;

    const vec2 offset                     = gl_SamplePosition - vec2(0.5, 0.5);
    const float pos_interpolated_at_offset = interpolateAtOffset(fs_in_pos_screen_fragment[0], offset);
    const bool valuesEqual                 = (abs(pos_interpolated_at_offset - fs_in_pos_screen_sample[0]) < threshold);

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
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
#version 440
layout(location = 0)        in vec2 fs_in_pos_screen_fragment;
layout(location = 1) sample in vec2 fs_in_pos_screen_sample;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const float threshold = 0.15625;

    const vec2 offset                     = gl_SamplePosition - vec2(0.5, 0.5);
    const float pos_interpolated_at_offset = interpolateAtOffset(fs_in_pos_screen_fragment[1], offset);
    const bool valuesEqual                 = (abs(pos_interpolated_at_offset - fs_in_pos_screen_sample[1]) < threshold);

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 440
layout(location = 0) centroid in vec2 fs_in_pos_screen_centroid;
layout(location = 1) sample   in vec2 fs_in_pos_screen_sample;

layout(location = 0) out vec4 fs_out_color;

layout(push_constant) uniform PushConstants {
   uint component;
};

void main (void)
{
    const float threshold = 0.15625;

    const float pos_interpolated_at_sample = interpolateAtSample(fs_in_pos_screen_centroid[component], gl_SampleID);
    const bool  valuesEqual                = (abs(pos_interpolated_at_sample - fs_in_pos_screen_sample[component]) < threshold);

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 440
layout(location = 0) sample   in vec2 fs_in_pos_screen_sample[2];
layout(location = 2) centroid in vec2 fs_in_pos_screen_centroid[2];

layout(location = 0) out vec4 fs_out_color;

layout(push_constant) uniform PushConstants {
   uint component;
};

void main (void)
{
    const float threshold = 0.0005;

    const float pos_interpolated_at_centroid = interpolateAtCentroid(fs_in_pos_screen_sample[1][component]);
    const bool  valuesEqual                  = (abs(pos_interpolated_at_centroid - fs_in_pos_screen_centroid[1][component]) < threshold);

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 440
layout(location = 0)        in vec2 fs_in_pos_screen_fragment;
layout(location = 1) sample in vec2 fs_in_pos_screen_sample;

layout(location = 0) out vec4 fs_out_color;

layout(push_constant) uniform PushConstants {
   uint component;
};

void main (void)
{
    const float threshold = 0.15625;

    const vec2 offset                     = gl_SamplePosition - vec2(0.5, 0.5);
    const float pos_interpolated_at_offset = interpolateAtOffset(fs_in_pos_screen_fragment[component], offset);
    const bool valuesEqual                 = (abs(pos_interpolated_at_offset - fs_in_pos_screen_sample[component]) < threshold);

    if (valuesEqual)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 440
layout(location = 0) in vec4 vs_in_position_ndc;
layout(location = 1) in vec3 vs_in_barCoord;

layout(location = 0) out vec3 vs_out_barCoord;

out gl_PerVertex {
    vec4  gl_Position;
};
void main (void)
{
    gl_Position = vs_in_position_ndc;
    vs_out_barCoord = vs_in_barCoord;
}
#version 440
layout(location = 0) centroid in vec3 fs_in_barCoord;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    if( all(greaterThanEqual(fs_in_barCoord, vec3(0.0))) && all(lessThanEqual(fs_in_barCoord, vec3(1.0))) )
            fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
            fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 440
layout(location = 0) in vec4 vs_in_position_ndc;
layout(location = 1) in vec2 vs_in_position_screen;

layout(location = 0) out vec2 vs_out_pos_screen;
layout(location = 1) out vec2 vs_out_offset;

out gl_PerVertex {
    vec4  gl_Position;
};
void main (void)
{
    gl_Position = vs_in_position_ndc;
    vs_out_pos_screen = vs_in_position_screen;
    vs_out_offset = vs_in_position_ndc.xy * 0.5;
}
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
