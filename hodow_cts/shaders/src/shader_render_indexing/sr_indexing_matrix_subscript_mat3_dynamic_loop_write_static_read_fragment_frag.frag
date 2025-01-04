#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(res, 1.0);
}
