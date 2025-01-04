#version 450
layout(location = 0) in float in_color;
layout(location = 0) out uint out_color;
void main()
{
    out_color = uint(in_color);
}
