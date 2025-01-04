#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; }; 
void main (void)
{
    highp float res = fwidth(7.7) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
