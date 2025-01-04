#version 450
layout(location = 0) out int layerIndex;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1)) * 4.0f - 1.0f;
    gl_Position = vec4(pos, 0.0f, 1.0f);
    layerIndex = gl_InstanceIndex;
}
