#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x2 tmp;
    tmp[ui_zero]  = vec2(coords);
    tmp[ui_one]    = vec2(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec2(coords.zwxy) * 0.25;
    mediump vec2 res = vec2(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(res, 0.0, 1.0);
}
