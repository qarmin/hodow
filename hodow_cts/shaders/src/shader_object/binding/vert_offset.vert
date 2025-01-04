#version 450
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    if (gl_VertexIndex > 4) {
        pos.x += 0.2f;
    }
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
}
