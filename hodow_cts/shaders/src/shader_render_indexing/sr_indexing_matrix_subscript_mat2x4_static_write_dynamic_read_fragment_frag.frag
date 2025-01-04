#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    o_color = vec4(res);
}
