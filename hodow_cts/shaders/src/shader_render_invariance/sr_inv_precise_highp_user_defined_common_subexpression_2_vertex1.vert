#version 450
layout(location = 0) in highp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
layout(location = 1) precise highp out vec4 v_value;
void main ()
{
    highp vec4 a = 1.0e14 * (a_input.xxxx + a_input.yyyy);
    highp vec4 b = (1.0e14 * (a_input.xxxx + a_input.yyyy)) * (1.0e14 * (a_input.xxxx + a_input.yyyy)) / 1.0e14 / 1.0e14;
    highp vec4 c = a * a;
    highp vec4 d = c / 1.0e14 / 1.0e14;
    v_unrelated = a + b + c + d;
    v_value = a_input + d;
    gl_Position = v_value;
}
