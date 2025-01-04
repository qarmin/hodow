#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; };
layout(binding = 2) uniform highp sampler2D u_sampler;
void main (void)
{
    highp vec4 tex = texture(u_sampler, v_coord);
    highp vec3 res = dFdxCoarse(tex.xyz) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
