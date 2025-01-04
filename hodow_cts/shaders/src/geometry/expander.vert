#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_color;
layout(location = 0) out highp vec4 v_geom_FragColor;
void main (void)
{
    gl_Position = a_position;
    v_geom_FragColor = a_color;
}
