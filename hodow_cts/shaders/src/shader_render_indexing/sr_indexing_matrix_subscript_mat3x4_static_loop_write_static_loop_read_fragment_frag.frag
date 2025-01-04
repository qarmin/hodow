#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    for (int i = 0; i < 3; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 3; i++)
        res += tmp[i];
    o_color = vec4(res);
}
