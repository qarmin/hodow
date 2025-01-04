#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 5) uniform something5 { mediump vec3 u_arr[4]; };

void main()
{
    mediump vec3 res = vec3(0.0);
    res += u_arr[0];
    res += u_arr[1];
    res += u_arr[2];
    res += u_arr[3];
    o_color = vec4(res, 1.0);
}
