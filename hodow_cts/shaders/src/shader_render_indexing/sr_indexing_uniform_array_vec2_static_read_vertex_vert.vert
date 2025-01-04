#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 5) uniform something5 { mediump vec2 u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump vec2 res = vec2(0.0);
    res += u_arr[0];
    res += u_arr[1];
    res += u_arr[2];
    res += u_arr[3];
    v_color = vec4(res, 0.0, 1.0);
}
