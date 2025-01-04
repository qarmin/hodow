#version 450
layout(location = 0) in highp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
invariant gl_Position;
layout(location = 1) invariant highp out vec4 v_value;
void main ()
{
    highp vec4 value = a_input;
    for (mediump int i = 0; i < 14; ++i)
    {
        value *= 1.9;
        if (i == 11)
            v_unrelated = value;
    }
    v_value = vec4(value.xyz / 1.0e4 + a_input.xyz * 0.1, 1.0);
    gl_Position = v_value;
}
