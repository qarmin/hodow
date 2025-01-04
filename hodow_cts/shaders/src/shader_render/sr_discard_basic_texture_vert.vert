#version 310 es
layout(location=0) in  highp   vec4 a_position;
layout(location=1) in  highp   vec4 a_coords;
layout(location=2) in  highp   vec4 a_one;
layout(location=0) out mediump vec4 v_color;
layout(location=1) out mediump vec4 v_coords;

layout(location=2) out mediump vec4 v_one;
void main (void)
{
    gl_Position = a_position;
    v_color = vec4(a_coords.xyz, 1.0);
    v_coords = a_coords;
    v_one = a_one;
}
