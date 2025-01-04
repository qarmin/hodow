#version 450
layout (input_attachment_index = 0, binding = 0) uniform subpassInput depthStencil;
void main (void)
{
    float inputDepth = subpassLoad(depthStencil).x;
    gl_FragDepth = inputDepth - 0.02;
}
