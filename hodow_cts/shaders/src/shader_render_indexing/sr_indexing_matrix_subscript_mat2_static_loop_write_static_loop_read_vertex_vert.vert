#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat2 tmp;
    for (int i = 0; i < 2; i++)
    {
        tmp[i] = vec2(coords);
        coords = coords.yzwx * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec4(res, 0.0, 1.0);
}
