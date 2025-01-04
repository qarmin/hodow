#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; }; 
void main (void)
{
    highp vec3 res = fwidthCoarse(vec3(1e2, 8.0, 0.01)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
