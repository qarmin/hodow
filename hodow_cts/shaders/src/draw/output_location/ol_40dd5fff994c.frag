#version 430
layout(location = 0) in vec4 color_in0;
layout(location = 1) in vec4 color_in1;
layout(location = 0) out vec4 frag_out0;
layout(location = 1) out vec4 frag_out1;
void main()
{
    if (((int(gl_FragCoord.x) / 5) % 2) == ((int(gl_FragCoord.y) / 5) % 2))
    {
        frag_out0 = color_in0;
        frag_out1 = color_in1;
    }
    else
    {
        frag_out0 = color_in1;
        frag_out1 = color_in0;
    }
}
