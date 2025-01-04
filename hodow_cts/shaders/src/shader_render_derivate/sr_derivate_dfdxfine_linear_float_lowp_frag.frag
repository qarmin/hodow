#version 450
layout(location = 0) in lowp float v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp float u_scale; };
layout(binding = 1, std140) uniform Bias { lowp float u_bias; };
void main (void)
{
    lowp float res = dFdxFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
