#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    tmp[ui_zero]  = vec3(coords);
    tmp[ui_one]    = vec3(coords.yzwx) * 0.5;
    tmp[ui_two]    = vec3(coords.zwxy) * 0.25;
    tmp[ui_three] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    res += tmp[ui_three];
    v_color = vec4(res, 1.0);
}
