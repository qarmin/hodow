#version 440

layout(set = 0, binding = 0, std430) buffer Output
{
    int result[];
} sb_out;

void main (void)
{
    for (highp uint ndx = 0u; ndx < 16u; ndx++)
    {
        sb_out.result[ndx] = int(ndx);
    }
    gl_PointSize = 1.0f;
}
