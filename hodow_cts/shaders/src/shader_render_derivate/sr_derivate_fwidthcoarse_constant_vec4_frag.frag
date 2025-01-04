#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; }; 
void main (void)
{
    highp vec4 res = fwidthCoarse(vec4(1.0, 7.2, -1e5, 0.0)) * u_scale + u_bias;
    o_color = res;
}
