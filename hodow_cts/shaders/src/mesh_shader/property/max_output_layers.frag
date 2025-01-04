#version 450

layout (location=0) out uvec4 outColor;

void main (void) {
    outColor = uvec4(uint(gl_Layer) + 1u, 0, 0, 0);
}
