#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec2 arr[40];
    arr[0] = vec2(0.125, 0.25);
    arr[1] = vec2(0.125, 0.25) * 0.5;
    arr[2] = vec2(0.125, 0.25) * 0.25;
    arr[3] = vec2(0.125, 0.25) * 0.125;
    int i = 4;
    arr[i++] = vec2(4.0);
    arr[i++] = vec2(5.0);
    arr[i++] = vec2(6.0);
    arr[i++] = vec2(7.0);
    arr[i++] = vec2(8.0);
    arr[i++] = vec2(9.0);
    arr[i++] = vec2(10.0);
    arr[i++] = vec2(11.0);
    arr[i++] = vec2(12.0);
    arr[i++] = vec2(13.0);
    arr[i++] = vec2(14.0);
    arr[i++] = vec2(15.0);
    arr[i++] = vec2(16.0);
    arr[i++] = vec2(17.0);
    arr[i++] = vec2(18.0);
    arr[i++] = vec2(19.0);
    arr[i++] = vec2(20.0);
    arr[i++] = vec2(21.0);
    arr[i++] = vec2(22.0);
    arr[i++] = vec2(23.0);
    arr[i++] = vec2(24.0);
    arr[i++] = vec2(25.0);
    arr[i++] = vec2(26.0);
    arr[i++] = vec2(27.0);
    arr[i++] = vec2(28.0);
    arr[i++] = vec2(29.0);
    arr[i++] = vec2(30.0);
    arr[i++] = vec2(31.0);
    arr[i++] = vec2(32.0);
    arr[i++] = vec2(33.0);
    arr[i++] = vec2(34.0);
    arr[i++] = vec2(35.0);
    arr[i++] = vec2(36.0);
    arr[i++] = vec2(37.0);
    arr[i++] = vec2(38.0);
    arr[i++] = vec2(39.0);
    mediump vec2 res = vec2(0.0);
    for (int i = 0; i < ui_four; i++)
        res += arr[i];
    o_color = vec4(res, 0.0, 1.0);
}
