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
