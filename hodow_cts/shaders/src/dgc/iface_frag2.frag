#version 460
layout (location=0) out vec4 outColor;
layout (location=1) in float red;
layout (location=4) in float blue;
void main (void) {
    outColor = vec4(red, 1.0, blue, 1.0);
}
