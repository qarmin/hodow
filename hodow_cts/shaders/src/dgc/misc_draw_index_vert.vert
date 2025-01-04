#version 460
layout (location=0) in vec4 inPos;
layout (location=0) out vec4 outColor;
void main (void) {
    gl_Position = inPos;
    outColor = vec4(1.0, float(gl_DrawID), float(gl_BaseInstance), 1.0);
}
