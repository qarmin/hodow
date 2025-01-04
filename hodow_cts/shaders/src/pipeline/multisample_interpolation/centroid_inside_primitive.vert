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
