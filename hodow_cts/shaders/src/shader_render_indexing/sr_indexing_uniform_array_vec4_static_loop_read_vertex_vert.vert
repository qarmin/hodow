#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 5) uniform something5 { mediump vec4 u_arr[4]; };

void main()
{
    gl_Position = a_position;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < 4; i++)
        res += u_arr[i];
    v_color = vec4(res);
}
