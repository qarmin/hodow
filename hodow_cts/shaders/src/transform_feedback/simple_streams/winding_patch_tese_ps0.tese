#version 450
layout(triangles, ccw) in;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;


void main (void)
{
    idx_out = gl_PrimitiveID;
}
