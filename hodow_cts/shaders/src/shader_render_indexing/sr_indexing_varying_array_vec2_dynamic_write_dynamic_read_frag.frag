#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(location = 0) in mediump vec2 var[4];

void main()
{
    mediump vec2 res = vec2(0.0);
    res += var[ui_zero];
    res += var[ui_one];
    res += var[ui_two];
    res += var[ui_three];
    o_color = vec4(res, 0.0, 1.0);
}
