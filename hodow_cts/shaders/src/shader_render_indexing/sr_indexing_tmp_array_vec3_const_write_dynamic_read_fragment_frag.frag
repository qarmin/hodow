#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec3 arr[40];
    arr[0] = vec3(0.125, 0.25, 0.5);
    arr[1] = vec3(0.125, 0.25, 0.5) * 0.5;
    arr[2] = vec3(0.125, 0.25, 0.5) * 0.25;
    arr[3] = vec3(0.125, 0.25, 0.5) * 0.125;
    int i = 4;
    arr[i++] = vec3(4.0);
    arr[i++] = vec3(5.0);
    arr[i++] = vec3(6.0);
    arr[i++] = vec3(7.0);
    arr[i++] = vec3(8.0);
    arr[i++] = vec3(9.0);
    arr[i++] = vec3(10.0);
    arr[i++] = vec3(11.0);
    arr[i++] = vec3(12.0);
    arr[i++] = vec3(13.0);
    arr[i++] = vec3(14.0);
    arr[i++] = vec3(15.0);
    arr[i++] = vec3(16.0);
    arr[i++] = vec3(17.0);
    arr[i++] = vec3(18.0);
    arr[i++] = vec3(19.0);
    arr[i++] = vec3(20.0);
    arr[i++] = vec3(21.0);
    arr[i++] = vec3(22.0);
    arr[i++] = vec3(23.0);
    arr[i++] = vec3(24.0);
    arr[i++] = vec3(25.0);
    arr[i++] = vec3(26.0);
    arr[i++] = vec3(27.0);
    arr[i++] = vec3(28.0);
    arr[i++] = vec3(29.0);
    arr[i++] = vec3(30.0);
    arr[i++] = vec3(31.0);
    arr[i++] = vec3(32.0);
    arr[i++] = vec3(33.0);
    arr[i++] = vec3(34.0);
    arr[i++] = vec3(35.0);
    arr[i++] = vec3(36.0);
    arr[i++] = vec3(37.0);
    arr[i++] = vec3(38.0);
    arr[i++] = vec3(39.0);
    mediump vec3 res = vec3(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    o_color = vec4(res, 1.0);
}
