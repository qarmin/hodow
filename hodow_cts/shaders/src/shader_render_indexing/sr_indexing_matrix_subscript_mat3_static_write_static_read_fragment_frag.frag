#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res, 1.0);
}
