#version 450
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inColor;
layout (location=0) out vec4 outColor;
layout (set = 0, binding = 0) buffer ssbo {
    int data[];
} outData;
void main (void) {
    gl_Position = inPos;
    outColor = inColor;
    outData.data[gl_VertexIndex] = gl_VertexIndex + 1;
}
