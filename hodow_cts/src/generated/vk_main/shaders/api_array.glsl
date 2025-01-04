#version 310 es
layout(location = 0) in highp vec4 a_position;
void main (void) { gl_Position = a_position; }
#version 310 es
layout(location = 0) out lowp vec4 o_color;
void main (void) { o_color = vec4(1.0, 0.0, 1.0, 1.0); }
