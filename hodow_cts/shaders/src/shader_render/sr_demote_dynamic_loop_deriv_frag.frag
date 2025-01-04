#version 310 es
#extension GL_EXT_demote_to_helper_invocation : enable
layout(location = 0) in mediump vec4 v_color;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump vec4 a_one;
layout(location = 0) out mediump vec4 o_color;
layout(set = 0, binding = 2) uniform sampler2D    ut_brick;
layout(set = 0, binding = 0) uniform block0 { mediump int  ui_one; };

layout(set = 0, binding = 1) uniform block1 { mediump int  ui_two; };

void main (void)
{
    o_color = v_color;
    for (int i = 0; i < ui_two; i++)
    {
        if (i > 0) {
              ivec2 f = ivec2(gl_FragCoord.xy);
  int lsb = (f.x | f.y)&1;
  if (lsb != 0) demote;
  bool isHelper = helperInvocationEXT();
  highp vec2 dx = dFdx(a_one.xy + gl_FragCoord.xy);
  highp vec2 dy = dFdy(a_one.xy + gl_FragCoord.xy);
  highp float dh = dFdx(float(isHelper));
  bool valid = abs(dx.x-1.0) < 0.01 && dx.y == 0.0 && dy.x == 0.0 && abs(dy.y-1.0) < 0.01 && abs(dh-1.0) < 0.1 && !isHelper;
  if (valid) demote;
  o_color = vec4(1,0,0,1);
;
        }
    }
}
