#version 430
layout(location = 0) smooth in float color_in;
layout(location = 0) out highp float frag_out;
void main()
{
    frag_out = color_in;
}
