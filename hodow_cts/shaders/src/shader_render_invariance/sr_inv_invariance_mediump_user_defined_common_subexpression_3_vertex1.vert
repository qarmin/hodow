#version 450
layout(location = 0) in mediump vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
invariant gl_Position;
layout(location = 1) invariant highp out vec4 v_value;
void main ()
{
    mediump float x = a_input.x * 0.2;
    mediump vec4 a = a_input.xxyx * 0.7;
    mediump vec4 b = a_input.yxyz * 0.7;
    mediump vec4 c = a_input.zxyx * 0.5;
    mediump vec4 f = x*a + x*b + x*c;
    v_unrelated = f;
    mediump vec4 g = x * (a + b + c);
    v_value = a_input + g;
    gl_Position = v_value;
}
