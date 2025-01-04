#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    mediump float res = 0.0;
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
