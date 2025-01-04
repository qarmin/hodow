#version 430
layout(location = 0) smooth in vec4 color_in;
layout(location = 0) out highp vec2 frag_out;
void main()
{
    frag_out = color_in.xy;
}
