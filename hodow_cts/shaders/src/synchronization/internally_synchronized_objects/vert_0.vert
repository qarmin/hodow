#version 440

layout(set = 0, binding = 0, std430) buffer Output
{
    int result[];
} sb_out;

void main (void)
{
   sb_out.result[gl_VertexIndex] = int(gl_VertexIndex);
   gl_PointSize = 1.0f;
}
