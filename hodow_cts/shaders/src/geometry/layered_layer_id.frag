#version 450

layout(location = 0) out vec4 o_color;

void main(void)
{
    o_color = vec4( (gl_Layer    % 2) == 1 ? 1.0 : 0.5,
                   ((gl_Layer/2) % 2) == 1 ? 1.0 : 0.5,
                     gl_Layer         == 0 ? 1.0 : 0.0,
                                             1.0);
}
