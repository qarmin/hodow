#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    gl_SampleMask[0] = 0xAAAAAAAA;

    fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
