#version 440
layout(location = 0) in uint v_in_data;
layout(set = 0, binding = 0, std430) writeonly buffer Output {
    uint data[5];
} b_out;

void main (void)
{
    b_out.data[gl_VertexIndex] = v_in_data;
    gl_PointSize = 1.0f;
}
