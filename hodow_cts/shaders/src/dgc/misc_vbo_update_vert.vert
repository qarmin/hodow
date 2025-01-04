#version 460

layout(location=0) in vec4 inPos;
layout(location=1) in float inRed;
layout(location=2) in float inGreen;
layout(location=3) in float inBlue;

layout(location=0) out float outRed;
layout(location=1) out float outGreen;
layout(location=2) out float outBlue;

void main(void) {
    gl_Position = inPos;
    outRed = inRed;
    outGreen = inGreen;
    outBlue = inBlue;
}
