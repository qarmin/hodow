#version 460
out gl_PerVertex {
    vec4 gl_Position;
};
void main(void) {
    const float xCoord = float((gl_VertexIndex >> 0) & 1) * 2.0 - 1.0;
    const float yCoord = float((gl_VertexIndex >> 1) & 1) * 2.0 - 1.0;
    gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
}
