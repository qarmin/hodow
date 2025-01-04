#version 450
layout(location = 0) in highp vec3 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
void main (void)
{
    highp vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += dFdy(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
