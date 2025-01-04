#version 450
layout (location = 0) out vec2 texCoord;
void main()
{
    texCoord = vec2(gl_VertexIndex & 1u, (gl_VertexIndex >> 1u) & 1u);
    gl_Position = vec4(texCoord * 4.0f - 1.0f, 0.0f, 1.0f);
}
