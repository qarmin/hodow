#version 310 es
layout(location = 0) in highp vec4 a_position;
void main () { gl_Position = a_position; }
#version 310 es
layout(location = 0) out mediump vec4 o_color;
void main () { o_color = vec4(1.0, 0.5, 0.25, 1.0); }
#version 310 es
layout(binding = 0) buffer Input { highp uint dataIn[]; };
layout(binding = 1) buffer Output { highp uint dataOut[]; };
void main (void)
{
    dataOut[gl_GlobalInvocationID.x] = ~dataIn[gl_GlobalInvocationID.x];
}
