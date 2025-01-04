#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    tmp[ui_three] = coords.w * 0.125;
    mediump float res = 0.0;
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
