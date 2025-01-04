#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    tmp = coords.xy * vec4(1.0, 0.5, 0.25, 0.125).xy;
    mediump float res = 0.0;
    res = dot(tmp, vec2(1.0));
    v_color = vec3(res);
}
