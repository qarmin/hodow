#version 450
layout(location = 0) in lowp vec3 v_coord;
layout(location = 0) out lowp vec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec3 u_bias; };
void main (void)
{
    lowp vec3 res = dFdyFine(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
