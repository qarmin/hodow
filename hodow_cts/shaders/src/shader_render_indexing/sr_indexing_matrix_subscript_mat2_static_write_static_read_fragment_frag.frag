#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2 tmp;
    tmp[0] = vec2(coords);
    tmp[1] = vec2(coords.yzwx) * 0.5;
    mediump vec2 res = vec2(0.0);
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(res, 0.0, 1.0);
}
