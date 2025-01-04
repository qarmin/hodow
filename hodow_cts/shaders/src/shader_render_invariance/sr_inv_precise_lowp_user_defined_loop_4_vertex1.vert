#version 450
layout(location = 0) in lowp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
layout(location = 1) precise highp out vec4 v_value;
void main ()
{
    lowp vec4 position = vec4(0.0, 0.0, 0.0, 0.0);
    lowp vec4 value1 = a_input;
    lowp vec4 value2 = a_input;
    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);
    for (mediump int i = 0; i < 6; ++i)
    {
        value1 *= 1.1;
        v_unrelated = v_unrelated*1.3 + a_input.xyzx * value1.xyxw;
    }
    for (mediump int i = 0; i < 6; ++i)
    {
        value2 *= 1.1;
        position = position*1.3 + a_input.xyzx * value2.xyxw;
    }
    v_value = a_input + 0.05 * vec4(fract(position.xyz / 1.0e0), 1.0);
    gl_Position = v_value;
}
