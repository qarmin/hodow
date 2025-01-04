#version 450
layout (location=0) in float in_value;
layout (location=0) out vec4 out_color;
void main()
{
    out_color = vec4(in_value);
}
