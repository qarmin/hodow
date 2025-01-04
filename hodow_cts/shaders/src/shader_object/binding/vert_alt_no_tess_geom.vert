#version 450
#if ${unused} == 1
layout (location = 0) out vec4 color;
#endif
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4((pos - 0.5f) * 2 * 1.5f, 0.0f, 1.0f);
#if ${unused} == 1
    color = vec4(1.0f);
#endif
}
