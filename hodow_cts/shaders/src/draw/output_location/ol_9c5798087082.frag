#version 430
layout(location = 0) flat in uvec2 color_in;
layout(location = 0) out highp uvec2 frag_out;
void main()
{
    frag_out = color_in;
}
