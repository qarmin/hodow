#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in ivec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    gl_Position = inPos;
    outColor = vec4(inColor);
}
