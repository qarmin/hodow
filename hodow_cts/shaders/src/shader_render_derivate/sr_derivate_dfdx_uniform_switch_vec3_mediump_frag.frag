#version 450
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res;
    switch (ui_one)
    {
        case 0: res = dFdx(-v_coord) * u_scale + u_bias;    break;
        case 1: res = dFdx(v_coord) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
