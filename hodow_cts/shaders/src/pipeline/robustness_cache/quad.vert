#version 450
void main()
{
    vec2 vertex = vec2(gl_VertexIndex & 1u, (gl_VertexIndex >> 1u) & 1u);
    gl_Position = vec4(vertex * 2.0f - 1.0f, 0.0f, 1.0f);
}
