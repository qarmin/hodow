#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 arr[4];
    arr[0] = vec2(coords);
    arr[1] = vec2(coords) * 0.5;
    arr[2] = vec2(coords) * 0.25;
    arr[3] = vec2(coords) * 0.125;
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 1.0);
}
