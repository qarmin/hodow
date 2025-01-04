#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in float red;
layout (location=1) in float green;
layout (location=8) in float blue;
void main (void) {
    outColor = vec4(red, green, blue, 1.0);
}
