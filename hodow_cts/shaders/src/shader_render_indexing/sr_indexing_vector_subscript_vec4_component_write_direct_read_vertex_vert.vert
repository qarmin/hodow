#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    tmp.w = coords.w * 0.125;
    mediump float res = 0.0;
    res = dot(tmp, vec4(1.0));
    v_color = vec3(res);
}
