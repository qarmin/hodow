#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_vertexNdx;
layout(location = 0) out highp vec4 v_geom_vertexNdx;
void main (void)
{
    gl_Position = a_position;
    v_geom_vertexNdx = a_vertexNdx;
}
