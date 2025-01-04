#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec4 u_bias; };
mediump vec4 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec4 res = dFdxFine(intermediateStore) * u_scale + u_bias;
    o_color = res;
}
