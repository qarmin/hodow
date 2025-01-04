#version 450
layout (location=0) flat in uint index;
layout (location=0) out vec4 outColor;
void main() {
    float r = bool(index & 4) ? 1.0f : 0.0f;
    float g = bool(index & 2) ? 1.0f : 0.0f;
    float b = bool(index & 1) ? 1.0f : 0.0f;
    outColor = vec4(r, g, b, 1.0f);
}
