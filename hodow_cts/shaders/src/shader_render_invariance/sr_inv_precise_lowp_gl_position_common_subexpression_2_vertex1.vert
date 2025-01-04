#version 450
layout(location = 0) in lowp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
void main ()
{
    lowp vec4 a = 1.1 * (a_input.xxxx + a_input.yyyy);
    lowp vec4 b = (1.1 * (a_input.xxxx + a_input.yyyy)) * (1.1 * (a_input.xxxx + a_input.yyyy)) / 1.1 / 1.1;
    lowp vec4 c = a * a;
    lowp vec4 d = c / 1.1 / 1.1;
    v_unrelated = a + b + c + d;
    gl_Position = a_input + d;
    
}
