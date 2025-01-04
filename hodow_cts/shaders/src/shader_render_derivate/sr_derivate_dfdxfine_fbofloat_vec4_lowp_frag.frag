#version 450
layout(location = 0) in lowp vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec4 u_bias; };
void main (void)
{
    lowp vec4 res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
