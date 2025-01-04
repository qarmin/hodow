#version 450
layout(location = 0) in highp vec2 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(location = 1) out highp vec2 intermediateStore;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; };
void main (void)
{
    intermediateStore = v_coord;
    highp vec2 res = fwidth(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
