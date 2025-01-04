#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
mediump vec2 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec2 res = fwidthCoarse(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
