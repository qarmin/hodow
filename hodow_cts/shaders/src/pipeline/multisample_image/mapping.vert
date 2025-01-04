#version 450
void main(void) {
    gl_Position = vec4(float(gl_VertexIndex & 1) * 2.0 - 1.0,
                       float((gl_VertexIndex >> 1) & 1) * 2.0 - 1.0, 0.0, 1.0);
}
