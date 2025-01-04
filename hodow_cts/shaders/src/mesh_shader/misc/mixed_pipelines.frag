#version 450

layout (location=0) out vec4 outColor;
layout (push_constant, std430) uniform PushConstantBlock {
    vec4 color;
} pc;

void main ()
{
    outColor = pc.color;
}
