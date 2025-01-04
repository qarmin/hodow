#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    tmp[3] = coords.w * 0.125;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec3(res);
}
