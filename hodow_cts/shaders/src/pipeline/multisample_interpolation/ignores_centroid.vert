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
