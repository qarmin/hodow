#version 460
void main(void) {
    // Full-screen clockwise triangle strip with 4 vertices.
    const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
    const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
    gl_Position = vec4(x, y, 0.0, 1.0);
}
