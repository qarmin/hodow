#version 450
layout (input_attachment_index = 0, binding = 0) uniform subpassInput depthOrStencilInput;
layout(location = 0) in vec2 inUV;
layout(location = 0) out float fragColor;
void main (void)
{
  fragColor = subpassLoad(depthOrStencilInput).x;
}
