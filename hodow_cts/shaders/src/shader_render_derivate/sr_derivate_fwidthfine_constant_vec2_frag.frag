#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; }; 
void main (void)
{
    highp vec2 res = fwidthFine(vec2(-0.0, 2.7)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
