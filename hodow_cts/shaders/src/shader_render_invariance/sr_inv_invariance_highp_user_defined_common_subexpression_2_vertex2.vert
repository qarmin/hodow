#version 450
layout(location = 0) in highp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
invariant gl_Position;
layout(location = 1) invariant highp out vec4 v_value;
void main ()
{
    highp vec4 a = 1.0e14 * (a_input.xxxx + a_input.yyyy);
    highp vec4 c = a * a;
    highp vec4 d = c / 1.0e14 / 1.0e14;
    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);
    v_value = a_input + d;
    gl_Position = v_value;
}
