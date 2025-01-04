#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
highp float intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    highp float res = dFdx(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
