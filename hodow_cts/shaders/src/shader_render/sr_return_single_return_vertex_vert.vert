#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;

vec4 getColor (void)
{
    return vec4(a_coords.xyz, 1.0);
}

void main (void)
{
    gl_Position = a_position;
    v_color = getColor();
}
