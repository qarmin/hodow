#version 450
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    vec2 offset = vec2(float((gl_VertexIndex / 4) & 1), float(((gl_VertexIndex / 4) >> 1) & 1));
    gl_Position = vec4(pos - 1.0f + offset, 0.0f, 1.0f);
}
