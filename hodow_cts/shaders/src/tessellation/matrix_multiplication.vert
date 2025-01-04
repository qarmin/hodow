#version 450
void main()
{
    gl_Position = vec4(gl_VertexIndex & 1u, (gl_VertexIndex >> 1u) & 1u, 0.0f, 1.0f);
}
