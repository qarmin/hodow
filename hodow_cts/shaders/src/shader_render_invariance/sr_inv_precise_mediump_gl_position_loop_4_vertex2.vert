#version 450
layout(location = 0) in mediump vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
void main ()
{
    mediump vec4 position = vec4(0.0, 0.0, 0.0, 0.0);
    mediump vec4 value2 = a_input;
    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);
    for (mediump int i = 0; i < 13; ++i)
    {
        value2 *= 1.9;
        position = position*1.3 + a_input.xyzx * value2.xyxw;
    }
    gl_Position = a_input + 0.05 * vec4(fract(position.xyz / 1.0e2), 1.0);
    
}
