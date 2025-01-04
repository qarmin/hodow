#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inColor;
layout (location=0) out vec4 vtxColor;
void main (void) {
    gl_Position = inPos;
    vtxColor = inColor;
}
#version 460
layout (location=0) in vec4 vtxColor;
layout (location=0) out vec4 fragColor;
void main (void) {
    fragColor = vtxColor;
}
