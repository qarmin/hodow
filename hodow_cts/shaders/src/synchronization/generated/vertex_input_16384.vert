#version 440
layout(location = 0) in uvec4 v_in_data;
layout(set = 0, binding = 0, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    b_out.data[gl_VertexIndex] = v_in_data;
    gl_PointSize = 1.0f;
}
