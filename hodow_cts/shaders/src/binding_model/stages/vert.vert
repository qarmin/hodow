#version 450

void main (void) {
    gl_Position = vec4(float(gl_VertexIndex & 1) * 2.0f - 1.0f, float((gl_VertexIndex >> 1) & 1) * 2.0f - 1.0f, 0.0f, 1.0f);
}
