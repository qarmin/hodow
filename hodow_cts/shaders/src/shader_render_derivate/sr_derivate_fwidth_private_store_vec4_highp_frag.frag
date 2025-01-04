#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp vec4 v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; };
highp vec4 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp vec4 res = fwidth(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
