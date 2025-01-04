#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
layout(binding = 2) uniform mediump sampler2D u_sampler;
void main (void)
{
    mediump vec4 tex = texture(u_sampler, v_coord);
    mediump vec4 res = fwidth(tex) * u_scale + u_bias;
    o_color = res;
}
