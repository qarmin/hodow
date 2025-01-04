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
    mediump mat4x3 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = vec3(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    o_color = vec4(res, 1.0);
}
