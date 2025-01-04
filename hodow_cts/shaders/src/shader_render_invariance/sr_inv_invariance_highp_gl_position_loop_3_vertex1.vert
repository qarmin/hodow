#version 450
layout(location = 0) in highp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
invariant gl_Position;
void main ()
{
    highp vec4 value = a_input;
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);
    for (mediump int i = 0; i < 14; ++i)
    {
        value *= 1.9;
        gl_Position += vec4(value.xyz / 1.0e3 + a_input.xyz * 0.1, 1.0);
        v_unrelated = gl_Position.xyzx * a_input;
    }
    
}
