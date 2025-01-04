#version 450

layout (input_attachment_index = 0, set = 0, binding = 0) uniform subpassInput inputColor;
layout(location = 0) out vec4 o_color0;

void main(void)
{
    vec4 in_color = subpassLoad(inputColor);
    o_color0 = vec4(1.0, in_color.y, 0.25, 1.0);
}
