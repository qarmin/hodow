#version 460
void main(void) {
    const float x = float((gl_VertexIndex >> 1) & 1) * 2.0 - 1.0;
    const float y = float((gl_VertexIndex >> 0) & 1) * 2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
