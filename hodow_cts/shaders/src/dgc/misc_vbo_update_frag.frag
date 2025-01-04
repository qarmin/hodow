#version 460

layout(location=0) in float inRed;
layout(location=1) in float inGreen;
layout(location=2) in float inBlue;

layout(location=0) out vec4 outColor;

void main(void) {
    outColor = vec4(inRed, inGreen, inBlue, 1.0);
}
