#version 450
layout(location = 0) in highp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
void main ()
{
    highp vec4 a = 1.0e14 * (a_input.xxxx + a_input.yyyy);
    highp vec4 c = a * a;
    highp vec4 d = c / 1.0e14 / 1.0e14;
    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);
    gl_Position = a_input + d;
    
}
