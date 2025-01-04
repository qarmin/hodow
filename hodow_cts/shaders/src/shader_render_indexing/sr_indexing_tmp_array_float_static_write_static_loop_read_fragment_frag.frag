#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump float coords = float(v_coords);
    mediump float arr[4];
    arr[0] = float(coords);
    arr[1] = float(coords) * 0.5;
    arr[2] = float(coords) * 0.25;
    arr[3] = float(coords) * 0.125;
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
