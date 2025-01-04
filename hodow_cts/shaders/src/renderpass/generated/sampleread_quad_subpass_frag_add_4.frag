#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    uint load = 0;
    uint expect = 0;
    for (int i = 0; i < 4; i++)
    {
        expect += (1 << i);
        if ((gl_SampleMaskIn[0] & (1 << i)) != 0)
            load += subpassLoad(i_color, i).r;
        else
            load += (1 << i);
    }
    o_color.r = (load == expect) ? 1.0 : 0.0;
}
