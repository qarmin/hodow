#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res);
}
