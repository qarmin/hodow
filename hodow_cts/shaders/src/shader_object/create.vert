#version 450
layout (location=0) in vec2 inPos;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos, 0.0f, 1.0f);
}
