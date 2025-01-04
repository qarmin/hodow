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
