#version 450
layout (location=0) flat out uint index;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    pos.y -= 0.5f * (gl_InstanceIndex % 3);
    pos.x -= 1.0f * (gl_InstanceIndex / 3);
    gl_Position = vec4(pos, 0.0f, 1.0f);
    index = gl_InstanceIndex + 1;
}
