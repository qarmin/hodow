#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(std140, binding = 5) uniform something5 { mediump vec2 u_arr[4]; };

void main()
{
    mediump vec2 res = vec2(0.0);
    res += u_arr[ui_zero];
    res += u_arr[ui_one];
    res += u_arr[ui_two];
    res += u_arr[ui_three];
    o_color = vec4(res, 0.0, 1.0);
}
