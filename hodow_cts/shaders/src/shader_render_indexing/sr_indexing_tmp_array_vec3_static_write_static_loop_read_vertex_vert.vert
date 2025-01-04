#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    arr[0] = vec3(coords);
    arr[1] = vec3(coords) * 0.5;
    arr[2] = vec3(coords) * 0.25;
    arr[3] = vec3(coords) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += arr[i];
    v_color = vec4(res, 1.0);
}
