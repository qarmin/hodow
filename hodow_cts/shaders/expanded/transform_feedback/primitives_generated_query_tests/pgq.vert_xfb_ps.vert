#version 450
layout(location=0) in vec2 inPosition;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
void main (void)
{
    gl_PointSize = 1.0;
     gl_Position = vec4(inPosition, 0, 1);
    out0 = vec4(42);
}
