#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump float arr[40];
    arr[0] = float(0.125);
    arr[1] = float(0.125) * 0.5;
    arr[2] = float(0.125) * 0.25;
    arr[3] = float(0.125) * 0.125;
    int i = 4;
    arr[i++] = float(4.0);
    arr[i++] = float(5.0);
    arr[i++] = float(6.0);
    arr[i++] = float(7.0);
    arr[i++] = float(8.0);
    arr[i++] = float(9.0);
    arr[i++] = float(10.0);
    arr[i++] = float(11.0);
    arr[i++] = float(12.0);
    arr[i++] = float(13.0);
    arr[i++] = float(14.0);
    arr[i++] = float(15.0);
    arr[i++] = float(16.0);
    arr[i++] = float(17.0);
    arr[i++] = float(18.0);
    arr[i++] = float(19.0);
    arr[i++] = float(20.0);
    arr[i++] = float(21.0);
    arr[i++] = float(22.0);
    arr[i++] = float(23.0);
    arr[i++] = float(24.0);
    arr[i++] = float(25.0);
    arr[i++] = float(26.0);
    arr[i++] = float(27.0);
    arr[i++] = float(28.0);
    arr[i++] = float(29.0);
    arr[i++] = float(30.0);
    arr[i++] = float(31.0);
    arr[i++] = float(32.0);
    arr[i++] = float(33.0);
    arr[i++] = float(34.0);
    arr[i++] = float(35.0);
    arr[i++] = float(36.0);
    arr[i++] = float(37.0);
    arr[i++] = float(38.0);
    arr[i++] = float(39.0);
    mediump float res = float(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
