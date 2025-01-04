#version 450
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };

mediump float computeRes (mediump float value)
{
    return dFdx(v_coord) * u_scale + u_bias;
}

void main (void)
{
    mediump float res = computeRes(v_coord);
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
