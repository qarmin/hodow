#version 450
layout(location = 0) in lowp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
void main ()
{
    lowp vec4 value = a_input;
    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);
    for (mediump int i = 0; i < 6; ++i)
    {
        value *= 1.1;
    }
    gl_Position = vec4(value.xyz / 2.0 + a_input.xyz * 0.1, 1.0);
    
}
