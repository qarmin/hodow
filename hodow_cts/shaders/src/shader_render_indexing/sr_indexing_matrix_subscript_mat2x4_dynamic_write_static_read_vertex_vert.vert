#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    tmp[ui_zero]  = vec4(coords);
    tmp[ui_one]    = vec4(coords.yzwx) * 0.5;
    mediump vec4 res = vec4(0.0);
    res += tmp[0];
    res += tmp[1];
    v_color = vec4(res);
}
