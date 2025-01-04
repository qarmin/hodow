#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(res, 0.0, 1.0);
}
