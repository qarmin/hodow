#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    gl_Position = a_position;
    mediump float coords = float(a_coords);
    mediump float arr[4];
    for (int i = 0; i < ui_four; i++)
    {
        arr[i] = float(coords);
        coords = coords * 0.5;
    }
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 0.0, 0.0, 1.0);
}
