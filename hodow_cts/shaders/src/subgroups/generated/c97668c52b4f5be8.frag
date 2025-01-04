#version 450
layout(location = 0) in vec4 in_color;
layout(location = 0) out uvec4 out_color;
void main()
{
    out_color = uvec4(in_color);
}
