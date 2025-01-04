#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 5) uniform something5 { mediump vec4 u_arr[4]; };

void main()
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += u_arr[i];
    o_color = vec4(res);
}
