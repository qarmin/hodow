#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    if (((gl_SampleMaskIn[0] >> gl_SampleID) & 0x01) == 0x01)
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
