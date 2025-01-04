#version 450
layout(location = 0) in highp vec4 a_input;
layout(location = 0) out highp vec4 v_unrelated;
precise gl_Position;
layout(location = 1) precise highp out vec4 v_value;
void main ()
{
    highp vec4 value = a_input;
    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);
    for (mediump int i = 0; i < 14; ++i)
    {
        value *= 1.9;
        v_unrelated += value;
    }
    v_value = vec4(value.xyz / 1.0e4 + a_input.xyz * 0.1, 1.0);
    gl_Position = v_value;
}
