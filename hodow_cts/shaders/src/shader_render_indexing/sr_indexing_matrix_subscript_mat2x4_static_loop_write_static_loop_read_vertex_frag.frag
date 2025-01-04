#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_color;

void main()
{
    o_color = v_color;
}
