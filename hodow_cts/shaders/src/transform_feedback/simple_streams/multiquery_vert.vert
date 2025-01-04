#version 450

layout(location = 0) out ivec4 out0;

void main(void)
{
    out0 = ivec4(gl_VertexIndex);
}
