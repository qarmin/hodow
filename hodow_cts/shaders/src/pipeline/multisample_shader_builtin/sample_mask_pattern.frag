#version 440

layout(location = 0) out vec4 fs_out_color;

layout(set = 0, binding = 0, std140) uniform SampleMaskBlock
{
    int sampleMaskPattern;
};
void main (void)
{
    if ((gl_SampleMaskIn[0] & ~sampleMaskPattern) != 0)
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
    else
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
}
