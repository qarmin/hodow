#version 450
layout(location = 0) out highp ivec4 o_color;
void main (void)
{
    o_color = ivec4(${r}, ${g}, ${b}, 0xffffffff);
}
