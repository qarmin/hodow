#version 450

layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position = vec4(1.0, 1.0, float(gl_VertexIndex) / 3.0 - 1.0, 1.0);
    gl_PointSize = 1.0;
}
