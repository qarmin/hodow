#version 430
layout(location = 0) smooth in vec2 color_in;
layout(location = 0) out mediump float frag_out;
void main()
{
    frag_out = color_in.x;
}
