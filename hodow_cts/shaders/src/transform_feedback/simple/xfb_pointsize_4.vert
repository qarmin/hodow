#version 450

layout(xfb_buffer = 3, xfb_offset = 0) out gl_PerVertex
{
float gl_PointSize;
};

void main(void)
{
gl_PointSize = float(gl_VertexIndex) / 32768.0f;
}
