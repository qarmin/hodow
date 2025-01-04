#version 430
layout(location = 0) smooth in vec3 color_in[3];
layout(location = 0) out highp vec3 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i];
}
