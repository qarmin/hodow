#version 460
layout (location=0) out vec4 outColor;
layout (location=5) in float red;
layout (location=6) in float green;
layout (location=10) in float blue;
layout (location=11) in float alpha;
void main (void) {
    outColor = vec4(red, green, blue, alpha);
}
