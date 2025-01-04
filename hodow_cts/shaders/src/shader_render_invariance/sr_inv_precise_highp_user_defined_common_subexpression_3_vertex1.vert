#version 450
layout(location = 0) in highp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
layout(location = 1) precise highp out vec4 v_value;
void main ()
{
    highp float x = a_input.x * 0.2;
    highp vec4 a = a_input.xxyx * 0.7;
    highp vec4 b = a_input.yxyz * 0.7;
    highp vec4 c = a_input.zxyx * 0.5;
    highp vec4 f = x*a + x*b + x*c;
    v_unrelated = f;
    highp vec4 g = x * (a + b + c);
    v_value = a_input + g;
    gl_Position = v_value;
}
