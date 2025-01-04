#version 450
layout (location=0) in float r;
layout (location=1) in float x;
layout (location=2) in float g;
layout (location=3) in float y;
layout (location=4) in float b;
layout (location=5) in float z;
layout (location=6) in float a;
layout (location=7) in float w;
layout (location=0) out vec4 outColor;
void main() {
    vec2 pos = vec2(-float(gl_InstanceIndex & 1), -float((gl_InstanceIndex >> 1) & 1));
    vec4 vertex = vec4(x, y, z, w);
    vec4 color = vec4(r, g, b, a);
    gl_Position = vertex + vec4(pos, 0.0f, 1.0f);
    outColor = color;
}
