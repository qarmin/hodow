#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec4 coords = vec4(a_coords);
    mediump vec4 tmp;
    tmp = coords.xyzw * vec4(1.0, 0.5, 0.25, 0.125).xyzw;
    mediump float res = 0.0;
    for (int i = 0; i < 4; i++)
        res += tmp[i];
    v_color = vec3(res);
}
