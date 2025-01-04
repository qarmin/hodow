#version 450
out gl_PerVertex {
	vec4 gl_Position;
};
highp float;
void main (void)
{
    gl_Position = vec4(((gl_VertexIndex + 2) / 3) % 2 == 0 ? -1.0 : 1.0,
                       ((gl_VertexIndex + 1) / 3) % 2 == 0 ? -1.0 : 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
void main (void)
{
    o_color = uvec4(1u << gl_SampleID, 0, 0, 0);
}
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
    for (int i = 0; i < 2; i++)
    {
        expect += (1 << i);
        if ((gl_SampleMaskIn[0] & (1 << i)) != 0)
            load += subpassLoad(i_color, i).r;
        else
            load += (1 << i);
    }
    o_color.r = (load == expect) ? 1.0 : 0.0;
}
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
    for (int i = 0; i < 8; i++)
    {
        expect += (1 << i);
        if ((gl_SampleMaskIn[0] & (1 << i)) != 0)
            load += subpassLoad(i_color, i).r;
        else
            load += (1 << i);
    }
    o_color.r = (load == expect) ? 1.0 : 0.0;
}
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
    for (int i = 0; i < 16; i++)
    {
        expect += (1 << i);
        if ((gl_SampleMaskIn[0] & (1 << i)) != 0)
            load += subpassLoad(i_color, i).r;
        else
            load += (1 << i);
    }
    o_color.r = (load == expect) ? 1.0 : 0.0;
}
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
    for (int i = 0; i < 32; i++)
    {
        expect += (1 << i);
        if ((gl_SampleMaskIn[0] & (1 << i)) != 0)
            load += subpassLoad(i_color, i).r;
        else
            load += (1 << i);
    }
    o_color.r = (load == expect) ? 1.0 : 0.0;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 0)) != 0)
    {
        uint load = subpassLoad(i_color, 0).r;
        result = (load == (1 << 0)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 1)) != 0)
    {
        uint load = subpassLoad(i_color, 1).r;
        result = (load == (1 << 1)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 2)) != 0)
    {
        uint load = subpassLoad(i_color, 2).r;
        result = (load == (1 << 2)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 3)) != 0)
    {
        uint load = subpassLoad(i_color, 3).r;
        result = (load == (1 << 3)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 4)) != 0)
    {
        uint load = subpassLoad(i_color, 4).r;
        result = (load == (1 << 4)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 5)) != 0)
    {
        uint load = subpassLoad(i_color, 5).r;
        result = (load == (1 << 5)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 6)) != 0)
    {
        uint load = subpassLoad(i_color, 6).r;
        result = (load == (1 << 6)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 7)) != 0)
    {
        uint load = subpassLoad(i_color, 7).r;
        result = (load == (1 << 7)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 8)) != 0)
    {
        uint load = subpassLoad(i_color, 8).r;
        result = (load == (1 << 8)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 9)) != 0)
    {
        uint load = subpassLoad(i_color, 9).r;
        result = (load == (1 << 9)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 10)) != 0)
    {
        uint load = subpassLoad(i_color, 10).r;
        result = (load == (1 << 10)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 11)) != 0)
    {
        uint load = subpassLoad(i_color, 11).r;
        result = (load == (1 << 11)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 12)) != 0)
    {
        uint load = subpassLoad(i_color, 12).r;
        result = (load == (1 << 12)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 13)) != 0)
    {
        uint load = subpassLoad(i_color, 13).r;
        result = (load == (1 << 13)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 14)) != 0)
    {
        uint load = subpassLoad(i_color, 14).r;
        result = (load == (1 << 14)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 15)) != 0)
    {
        uint load = subpassLoad(i_color, 15).r;
        result = (load == (1 << 15)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 16)) != 0)
    {
        uint load = subpassLoad(i_color, 16).r;
        result = (load == (1 << 16)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 17)) != 0)
    {
        uint load = subpassLoad(i_color, 17).r;
        result = (load == (1 << 17)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 18)) != 0)
    {
        uint load = subpassLoad(i_color, 18).r;
        result = (load == (1 << 18)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 19)) != 0)
    {
        uint load = subpassLoad(i_color, 19).r;
        result = (load == (1 << 19)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 20)) != 0)
    {
        uint load = subpassLoad(i_color, 20).r;
        result = (load == (1 << 20)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 21)) != 0)
    {
        uint load = subpassLoad(i_color, 21).r;
        result = (load == (1 << 21)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 22)) != 0)
    {
        uint load = subpassLoad(i_color, 22).r;
        result = (load == (1 << 22)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 23)) != 0)
    {
        uint load = subpassLoad(i_color, 23).r;
        result = (load == (1 << 23)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 24)) != 0)
    {
        uint load = subpassLoad(i_color, 24).r;
        result = (load == (1 << 24)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 25)) != 0)
    {
        uint load = subpassLoad(i_color, 25).r;
        result = (load == (1 << 25)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 26)) != 0)
    {
        uint load = subpassLoad(i_color, 26).r;
        result = (load == (1 << 26)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 27)) != 0)
    {
        uint load = subpassLoad(i_color, 27).r;
        result = (load == (1 << 27)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 28)) != 0)
    {
        uint load = subpassLoad(i_color, 28).r;
        result = (load == (1 << 28)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 29)) != 0)
    {
        uint load = subpassLoad(i_color, 29).r;
        result = (load == (1 << 29)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
#version 450
precision mediump int;
precision highp float;
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
    float result = 1.0;
    if ((gl_SampleMaskIn[0] & (1 << 30)) != 0)
    {
        uint load = subpassLoad(i_color, 30).r;
        result = (load == (1 << 30)) ? 1.0 : 0.0;
    }
    o_color.r = result;
}
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
