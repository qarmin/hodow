#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 31)) != 0)
    {
        uint load = subpassLoad(i_color, 31).r;
        result = (load == (1 << 31)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
