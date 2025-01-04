#version 450
layout(location = 0) in lowp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
invariant gl_Position;
layout(location = 1) invariant highp out vec4 v_value;
void main ()
{
    lowp vec4 a = 1.1 * (a_input.xxxx + a_input.yyyy);
    lowp vec4 c = a * a;
    lowp vec4 d = c / 1.1 / 1.1;
    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);
    v_value = a_input + d;
    gl_Position = v_value;
}
