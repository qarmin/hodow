#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump float v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
mediump float intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump float res = dFdxFine(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
