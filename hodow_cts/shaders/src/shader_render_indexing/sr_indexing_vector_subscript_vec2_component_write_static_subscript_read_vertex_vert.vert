#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    v_color = vec3(res);
}
