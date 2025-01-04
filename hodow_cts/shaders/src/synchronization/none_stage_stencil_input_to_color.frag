#version 450
layout (input_attachment_index = 0, binding = 0) uniform usubpassInput depthOrStencilInput;
layout(location = 0) in vec2 inUV;
layout(location = 0) out uint fragColor;
void main (void)
{
  fragColor = subpassLoad(depthOrStencilInput).x;
}
