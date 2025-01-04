#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = a_coords;
    mediump mat4x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    tmp[3] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    res += tmp[3];
    v_color = vec4(res, 1.0);
}
