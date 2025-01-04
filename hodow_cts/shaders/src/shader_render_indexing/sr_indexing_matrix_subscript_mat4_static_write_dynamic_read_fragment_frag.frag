#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    tmp[3] = vec4(coords.wxyz) * 0.125;
    mediump vec4 res = vec4(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(res);
}
