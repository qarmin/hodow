#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    if (gl_SamplePosition.x < 0.0 || gl_SamplePosition.x > 1.0 || gl_SamplePosition.y < 0.0 || gl_SamplePosition.y > 1.0)
        fs_out_color = vec4(0.0, 0.0, 1.0, 1.0);
    else
        fs_out_color = vec4(gl_SamplePosition.x, gl_SamplePosition.y, 0.0, 1.0);
}
