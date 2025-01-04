#version 440

layout(input_attachment_index = 0, set = 0, binding = 0) uniform subpassInput u_colors;
layout(location = 0) out highp vec4 o_color;

void main (void)
{
    o_color = subpassLoad(u_colors);
    o_color.g = 1.0f;
    o_color.a = 1.0f;
}
