#version 450

layout(push_constant) uniform pushConstants
{
    uint start;
} uInput;

layout(xfb_buffer = 2, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;

void main(void)
{
    idx_out = uInput.start + gl_VertexIndex;
}
