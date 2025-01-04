#version 450
layout(set = 0, binding = 0) buffer Output {
    uint values[4];
} buffer_out;

void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
    if (gl_VertexIndex == 0u)
        buffer_out.values[0] = 1u;
}
