#version 440

layout(set = 0, binding = 0, std430) buffer Output
{
    int result[];
} sb_out;

void main (void)
{
    for (int ndx = 15; ndx >= 0; ndx--)
    {
        sb_out.result[uint(ndx)] = ndx;
    }
    gl_PointSize = 1.0f;
}
