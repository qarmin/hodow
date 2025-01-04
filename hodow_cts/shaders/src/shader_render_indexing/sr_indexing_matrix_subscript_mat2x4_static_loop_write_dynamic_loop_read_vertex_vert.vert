#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2x4 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec4(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_two; i++)
        res += tmp[i];
    v_color = vec4(res);
}
