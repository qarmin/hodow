#version 450

layout(push_constant, std430) uniform PushConstantBlock
{
    uint  start;
    float width;
    float posY;
} pc;

layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;

void main(void)
{
    idx_out           = pc.start + gl_VertexIndex;
    const float posX  = ((float(gl_VertexIndex) + 0.5) / pc.width) * 2.0 - 1.0;
    gl_Position       = vec4(posX, pc.posY, 0.0, 1.0);
    gl_PointSize      = 1.0;
}
