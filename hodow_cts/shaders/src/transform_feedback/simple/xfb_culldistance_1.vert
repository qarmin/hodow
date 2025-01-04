#version 450

layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
float gl_CullDistance[7];
float gl_PointSize;
};

void main(void)
{
gl_PointSize = 1.0;
for (int i=0; i<7; i++) gl_CullDistance[i] = float(8 * gl_VertexIndex + i) / 32768.0f;
}
