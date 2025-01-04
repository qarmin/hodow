#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res;
    switch (ui_one)
    {
        case 0: res = fwidthFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
