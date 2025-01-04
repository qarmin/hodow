#version 450
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1)) - vec2(0.0001f);
    float z = 0.9f;
    if ((gl_VertexIndex & 1) > 0)
        z += 0.2f;
    if ((gl_InstanceIndex & 1) > 0)
        z -= 0.3f;
    gl_Position = vec4(pos - 0.5f, z, 1.0f);
    if (gl_VertexIndex == 0)
        buffer_out.values[0] = 1u;
}
