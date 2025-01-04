#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
layout(binding = 2, std140) uniform Ui_two { int ui_two; };
void main (void)
{
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_two; i++)
        res += fwidth(v_coord * float(i));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
