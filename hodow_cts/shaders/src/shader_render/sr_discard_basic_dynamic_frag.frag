#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

void main (void)
{
    o_color = v_color;
    if (v_coords.x+v_coords.y > 0.0) discard;
}
