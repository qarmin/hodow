#version 460
layout (location=0) in vec4 inPos;
void main(void) {
    gl_Position = inPos;
    gl_PointSize = 1.0f;
}
#version 460
layout (early_fragment_tests) in;
layout (location=0) out vec4 outColor;
void main(void) {
    gl_FragDepth = 0.25;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
layout (early_fragment_tests) in;
layout (location=0) out vec4 outColor;
void main(void) {
    gl_FragDepth = 0.125;
    outColor = vec4(1.0, 0.0, 1.0, 1.0);
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=0) out vec4 outColor;
void main (void) {
    gl_Position = inPos;
    outColor = vec4(1.0, float(gl_DrawID), float(gl_BaseInstance), 1.0);
}
#version 460
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = inColor;
}
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
#version 460

layout(location=0) in float inRed;
layout(location=1) in float inGreen;
layout(location=2) in float inBlue;

layout(location=0) out vec4 outColor;

void main(void) {
    outColor = vec4(inRed, inGreen, inBlue, 1.0);
}
#version 460
layout (push_constant, std430) uniform PCBlock { uint seqIndex; } pc;
layout (location=0) out uvec4 outColor;
void main(void) {
    outColor = uvec4(pc.seqIndex, 0u, 255u, 255u);
}
#version 460
layout (location=0) in vec4 inPos;
void main (void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    gl_Position = inPos;
    gl_PointSize = 1.0f;
    outColor = inColor;
}
#version 460
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = inColor.rgba;
}
#version 460
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = inColor.abgr;
}
#version 460
layout (location=0) in vec4 inPos;
layout (push_constant, std430) uniform PCBlock { vec4 offset; } pc;
void main (void)
{
    gl_Position = inPos + pc.offset;
}
#version 460
layout (location=0) out vec4 outColor;
void main (void)
{
    outColor = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
void main (void)
{
    outColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
void main (void)
{
    outColor = vec4(1.0, 1.0, 1.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
void main (void)
{
    outColor = vec4(1.0, 0.0, 1.0, 1.0);
}
#version 460
layout (location=0) in vec4 inPos;
void main (void)
{
    gl_Position = inPos;
}
#version 460
layout (location=0) out vec4 outColor;
layout (push_constant, std430) uniform PCBlock { uint seqIndex; } pc;
void main (void) {
    outColor = vec4(1.0, 1.0, float(pc.seqIndex), 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
layout (push_constant, std430) uniform PCBlock { uint seqIndex; } pc;
void main (void) {
    outColor = vec4(1.0, 0.0, float(pc.seqIndex), 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
layout (push_constant, std430) uniform PCBlock { uint seqIndex; } pc;
void main (void) {
    outColor = vec4(0.0, 0.0, float(pc.seqIndex), 1.0);
}
