#version 460
layout (location=0) in vec4 inPos;
layout (push_constant, std430) uniform PCBlock { vec4 offset; } pc;
void main (void)
{
    gl_Position = inPos + pc.offset;
}
