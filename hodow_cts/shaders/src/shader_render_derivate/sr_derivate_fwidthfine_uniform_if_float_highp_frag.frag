#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp float res;
    if (ub_true)        res = fwidthFine(v_coord) * u_scale + u_bias;
    else
        res = fwidthFine(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
