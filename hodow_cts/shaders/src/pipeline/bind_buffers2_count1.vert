#version 450
layout (location=0) in vec4 rgba;
layout (location=1) in vec4 xyzw;
layout (location=0) out vec4 outColor;
void main() {
    vec2 pos = vec2(-float(gl_InstanceIndex & 1), -float((gl_InstanceIndex >> 1) & 1));
    vec4 vertex = vec4(xyzw);
    vec4 color = vec4(rgba);
    gl_Position = vertex + vec4(pos, 0.0f, 1.0f);
    outColor = color;
}
