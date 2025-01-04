#version 430
layout(location = 0) smooth in vec4 color_in0;
layout(location = 1) flat in uvec2 color_in1;
layout(location = 2) smooth in float color_in2;
layout(location = 0) out mediump float frag_out0;
layout(location = 1) out lowp uvec2 frag_out1;
layout(location = 2) out highp vec4 frag_out2;
void main()
{
    frag_out0 = color_in2;
    frag_out1 = color_in1;
    frag_out2 = color_in0;
}
