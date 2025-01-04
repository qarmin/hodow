#version 450
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4((pos - 0.5f) * 1.5f, 0.0f, 1.0f);
}
