#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp vec4 res;
    if (ub_true)        res = dFdyCoarse(v_coord) * u_scale + u_bias;
    else
        res = dFdyCoarse(-v_coord) * u_scale + u_bias;
    o_color = res;
}
