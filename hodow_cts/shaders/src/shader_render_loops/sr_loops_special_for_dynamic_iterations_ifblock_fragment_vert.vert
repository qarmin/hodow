#version 310 es
layout(location=0) in highp vec4 a_position;
layout(location=1) in highp vec4 a_coords;
layout(location=3) in mediump float a_one;
layout(location=0) out mediump vec4 v_coords;
layout(location=1) out mediump float v_one;

void main()
{
    gl_Position = a_position;
    v_coords = a_coords;
    v_one = a_one;
}
