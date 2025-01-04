#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(std140, binding = 5) uniform something5 { mediump vec4 u_arr[4]; };

void main()
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += u_arr[i];
    o_color = vec4(res);
}
