#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat2x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
