#version 450
layout(location = 0) in lowp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
void main ()
{
    lowp vec4 value = a_input;
    v_unrelated = vec4(0.0, 0.0, -1.0, 1.0);
    for (mediump int i = 0; i < 6; ++i)
    {
        value *= 1.1;
        if (i == 2)
            gl_Position = a_input + 0.05 * vec4(fract(value.xyz / 1.0e0), 1.0);
        else
            v_unrelated = value + a_input;
    
    }
}
