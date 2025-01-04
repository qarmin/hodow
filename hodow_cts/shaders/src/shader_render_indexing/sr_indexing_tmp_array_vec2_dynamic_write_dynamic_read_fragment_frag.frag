#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    arr[ui_zero]  = vec2(coords);
    arr[ui_one]   = vec2(coords) * 0.5;
    arr[ui_two]   = vec2(coords) * 0.25;
    arr[ui_three] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 0.0, 1.0);
}
