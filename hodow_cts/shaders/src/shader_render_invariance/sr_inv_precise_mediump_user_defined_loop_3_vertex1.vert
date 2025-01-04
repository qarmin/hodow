#version 450
layout(location = 0) in mediump vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
layout(location = 1) precise highp out vec4 v_value;
void main ()
{
    mediump vec4 value = a_input;
    v_value = vec4(0.0, 0.0, 0.0, 0.0);
    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);
    for (mediump int i = 0; i < 13; ++i)
    {
        value *= 1.9;
        v_value += vec4(value.xyz / 1.0e3 + a_input.xyz * 0.1, 1.0);
        v_unrelated = v_value.xyzx * a_input;
    }
    gl_Position = v_value;
}
