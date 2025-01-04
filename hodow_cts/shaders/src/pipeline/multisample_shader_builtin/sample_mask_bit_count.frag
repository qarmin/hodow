#version 440

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    const int maskBitCount = bitCount(gl_SampleMaskIn[0]);

    if (maskBitCount < ${min_count} || maskBitCount > ${max_count})
        fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
    else
        fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
}
