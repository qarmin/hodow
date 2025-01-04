#version 450
layout(set = 0, input_attachment_index = 0, binding = 0) uniform subpassInput inGBuffer;
layout(location = 0) out vec4 outColor;
void main (void)
{
    outColor = subpassLoad(inGBuffer);
}
