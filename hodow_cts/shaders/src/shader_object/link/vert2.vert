#version 450
layout (binding = 0) buffer Result { uint result[4]; };
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
    result[gl_VertexIndex] = gl_VertexIndex + 1;
}
