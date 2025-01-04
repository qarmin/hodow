#version 460
layout (location=1) in vec4 inPos;
layout (location=0) out vec4 outColor;
void main(void) {
    const vec4 offset = vec4(-100.0);
    const vec4 finalColor = vec4(0.0, 0.0, 1.0, 1.0);
    outColor = max(inPos + offset, finalColor);
}
