#version 450
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
void main (void)
{
    highp float res = float(0.0);
    for (int i = 0; i < 2; i++)
        res += fwidthCoarse(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
