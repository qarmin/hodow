#version 460
layout (points) in;
layout (max_vertices=1, points) out;

layout (location = 0, xfb_buffer = 0, xfb_stride = 12, xfb_offset = 0) flat out float goku;
layout (location = 0, component = 1) flat out float trunks;
layout (location = 0, xfb_buffer = 0, xfb_stride = 12, xfb_offset = 8, component = 2) flat out float vegeta;

layout (push_constant, std430) uniform PushConstantBlock {
    vec3 values;
} pc;

void main ()
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

    goku   = pc.values.x;
    trunks = pc.values.y;
    vegeta = pc.values.z;

    EmitVertex();
}
