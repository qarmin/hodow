#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    mediump float res = 0.0;
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    v_color = vec3(res);
}
