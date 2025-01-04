#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec4(coords);
        coords = coords * 0.5;
    }
    mediump vec4 res = vec4(0.0);
    res += arr[0];
    res += arr[1];
    res += arr[2];
    res += arr[3];
    o_color = vec4(res);
}
