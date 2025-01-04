#version 450
layout (location=0) flat out uint index;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    pos.y -= 0.5f * (gl_InstanceIndex % 3);
    pos.x -= 1.0f * (gl_InstanceIndex / 3);
    gl_Position = vec4(pos, 0.0f, 1.0f);
    index = gl_InstanceIndex + 1;
}
#version 450
layout (location=0) flat in uint index;
layout (location=0) out vec4 outColor;
void main() {
    float r = bool(index & 4) ? 1.0f : 0.0f;
    float g = bool(index & 2) ? 1.0f : 0.0f;
    float b = bool(index & 1) ? 1.0f : 0.0f;
    outColor = vec4(r, g, b, 1.0f);
}
