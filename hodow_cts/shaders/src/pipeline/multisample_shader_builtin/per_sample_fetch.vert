#version 440
layout(location = 0) in vec4 vs_in_position_ndc;

out gl_PerVertex {
    vec4  gl_Position;
};
void main (void)
{
    gl_Position = vs_in_position_ndc;
}
