#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 arr[4];
    arr[0] = vec4(coords);
    arr[1] = vec4(coords) * 0.5;
    arr[2] = vec4(coords) * 0.25;
    arr[3] = vec4(coords) * 0.125;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    o_color = vec4(res);
}
