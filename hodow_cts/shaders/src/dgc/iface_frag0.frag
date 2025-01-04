#version 460
layout (location=0) out vec4 outColor;
layout (location=2) in float red;
void main (void) {
    outColor = vec4(red, 0.0, 0.0, 1.0);
}
