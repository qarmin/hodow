#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec4 v_coords;
layout(std140, set=0, binding=0) uniform buff0 {
  mediump int ui_zero;
};
layout(std140, set=0, binding=1) uniform buff1 {
  mediump int ui_one;
};
layout(std140, set=0, binding=2) uniform buff2 {
  mediump int ui_two;
};
layout(std140, set=0, binding=3) uniform buff3 {
  mediump int ui_three;
};
layout(std140, set=0, binding=4) uniform buff4 {
  mediump int ui_four;
};
layout(std140, set=0, binding=5) uniform buff5 {
  mediump int ui_five;
};
layout(std140, set=0, binding=6) uniform buff6 {
  mediump int ui_six;
};

void main()
{
    mediump vec4 coords = v_coords;
    mediump vec4 res = coords;
    while (true) { res = res.yzwx + vec4(1.0); break; }
    res -= vec4(1);
    o_color = vec4(res.rgb, 1.0);
}
