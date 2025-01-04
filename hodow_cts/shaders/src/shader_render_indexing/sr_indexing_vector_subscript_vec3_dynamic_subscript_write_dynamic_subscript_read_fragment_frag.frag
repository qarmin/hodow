#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp[ui_zero]  = coords.x;
    tmp[ui_one]    = coords.y * 0.5;
    tmp[ui_two]    = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    o_color = vec4(vec3(res), 1.0);
}
