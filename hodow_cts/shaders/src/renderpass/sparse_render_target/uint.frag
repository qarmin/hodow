#version 450
layout(location = 0) out highp uvec4 o_color;
void main (void)
{
    o_color = uvec4(${r}u, ${g}u, ${b}u, 0xffffffff);
}
