#version 450

layout(xfb_buffer = 7, xfb_offset = 0) out gl_PerVertex
{
float gl_CullDistance[4];
float gl_ClipDistance[1];
float gl_PointSize;
};

void main(void)
{
gl_PointSize = 1.0;
for (int i=0; i<4; i++) gl_CullDistance[i] = float(6 * gl_VertexIndex + i) / 32768.0f;
gl_ClipDistance[0] = float(6 * gl_VertexIndex + 4) / 32768.0f;
}
