#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    highp vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += dFdx(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = res;
}
