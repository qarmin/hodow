#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_true { bool ub_true; };
void main (void)
{
    highp vec2 res;
    if (ub_true)        res = fwidthCoarse(v_coord) * u_scale + u_bias;
    else
        res = fwidthCoarse(-v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
