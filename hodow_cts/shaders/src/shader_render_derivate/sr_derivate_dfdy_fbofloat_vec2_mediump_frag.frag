#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
void main (void)
{
    mediump vec2 res = dFdy(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 1.0));
}
