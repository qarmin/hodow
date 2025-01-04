#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_color;
layout(location = 0) out highp vec4 v_color;
layout (set=0, binding=0) uniform PointSize {
    highp float u_pointSize;
};
void main ()
{
    gl_Position = a_position;
    gl_PointSize = u_pointSize;
    v_color = a_color;
}
