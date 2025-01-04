#version 450
layout(location = 0) in lowp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
layout(location = 1) precise highp out vec4 v_value;
void main ()
{
    lowp vec4 a = 0.9 * a_input.zzxx + a_input.xzxy - 0.9 * a_input.zzxx;
    lowp vec4 b = 0.9 * a_input.zzxx;
    lowp vec4 c = b - 0.9 * a_input.zzxx + a_input.xzxy;
    lowp vec4 d = (1.15 * a_input.yzxx) * (1.15 * a_input.yzzw) * (1.1*0.87 * a_input.yzxx) * (0.87 * a_input.xzzy);
    lowp vec4 e = ((1.15 * a_input.yzxx) * (1.1*0.87 * a_input.yzxx)) * ((0.87 * a_input.xzzy) * (1.15 * a_input.yzzw));
    v_unrelated = a + b + c + d + e;
    v_value = a_input + fract(c) + e;
    gl_Position = v_value;
}
