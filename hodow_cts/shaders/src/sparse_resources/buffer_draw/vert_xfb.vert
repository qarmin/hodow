#version 450
layout(location = 0) in vec4 in_position;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint out_ndx;
out gl_PerVertex {
    vec4 gl_Position;
};
void main(void)
{
    gl_Position = in_position;
    out_ndx     = gl_VertexIndex;
}
