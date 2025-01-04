#version 450
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
void main (void)
{
    mediump vec4 res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = res;
}
