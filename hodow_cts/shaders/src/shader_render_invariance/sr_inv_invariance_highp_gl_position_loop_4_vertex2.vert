#version 450
layout(location = 0) in highp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
invariant gl_Position;
void main ()
{
    highp vec4 position = vec4(0.0, 0.0, 0.0, 0.0);
    highp vec4 value2 = a_input;
    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);
    for (mediump int i = 0; i < 14; ++i)
    {
        value2 *= 1.9;
        position = position*1.3 + a_input.xyzx * value2.xyxw;
    }
    gl_Position = a_input + 0.05 * vec4(fract(position.xyz / 1.0e2), 1.0);
    
}
