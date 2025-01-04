#version 450
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
mediump vec3 intermediateStore;
void main (void)
{
    intermediateStore = v_coord;
    if (mod(gl_FragCoord.y, 2.0f) == 1.0f) demote;
    mediump vec3 res = dFdy(intermediateStore) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
