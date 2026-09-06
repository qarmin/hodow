#version 310 es
layout(location = 0) in mediump vec4 frag_color;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    o_color = frag_color;
}
