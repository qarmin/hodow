#version 450
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };

mediump vec2 computeRes (mediump vec2 value)
{
    return dFdyFine(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump vec2 res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 1.0);
}
