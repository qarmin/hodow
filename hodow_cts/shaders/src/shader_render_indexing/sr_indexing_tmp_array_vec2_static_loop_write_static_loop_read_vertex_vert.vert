#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec2(coords);
        coords = coords * 0.5;
    }
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 1.0);
}
