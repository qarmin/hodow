#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    fs_out_color = vec4(float(gl_SampleID) / float(255), 0.0, 0.0, 1.0);
}
