#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in float inRed;
layout (location=2) in float inGreen;
layout (location=3) in float inBlue;

layout (location=0) out vec4 outColor;

layout (push_constant, std430) uniform PCBlock { vec4 offset; } pc;

void main (void)
{
    gl_Position = inPos + pc.offset;
    outColor = vec4(inRed, inGreen, inBlue, 1.0);
}
