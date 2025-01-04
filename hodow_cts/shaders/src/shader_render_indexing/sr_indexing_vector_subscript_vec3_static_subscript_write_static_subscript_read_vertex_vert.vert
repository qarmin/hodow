#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    v_color = vec3(res);
}
