#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp vec4 res;
    switch (ui_one)
    {
        case 0: res = dFdyFine(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdyFine(v_coord) * u_scale + u_bias;    break;
    }
    o_color = res;
}
