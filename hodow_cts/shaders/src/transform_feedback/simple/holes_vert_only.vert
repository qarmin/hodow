#version 460
layout (location = 0) in vec4 inPos;

layout (location = 0, xfb_buffer = 0, xfb_stride = 12, xfb_offset = 0) flat out float goku;
layout (location = 0, component = 1) flat out float trunks;
layout (location = 0, xfb_buffer = 0, xfb_stride = 12, xfb_offset = 8, component = 2) flat out float vegeta;

layout (push_constant, std430) uniform PushConstantBlock {
    vec3 values;
} pc;

void main ()
{
    gl_Position  = inPos;
    gl_PointSize = 1.0;

    goku   = pc.values.x;
    trunks = pc.values.y;
    vegeta = pc.values.z;
}
