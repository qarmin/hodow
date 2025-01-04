#version 450
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec4 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec4 res = fwidth(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
