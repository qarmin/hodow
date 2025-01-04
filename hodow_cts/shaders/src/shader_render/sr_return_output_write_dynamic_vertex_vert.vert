#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

void main ()
{
    gl_Position = a_position;
    v_color = vec4(a_coords.xyz, 1.0);
    if (a_coords.x+a_coords.y >= 0.0)
        return;
    v_color = vec4(a_coords.wzy, 1.0);
}
