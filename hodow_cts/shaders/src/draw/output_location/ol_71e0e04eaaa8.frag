#version 430
layout(location = 0) smooth in vec3 color_in;
layout(location = 0) out mediump vec3 frag_out;
void main()
{
    frag_out = color_in;
}
