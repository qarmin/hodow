#version 450
layout(location = 0) in mediump vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
invariant gl_Position;
layout(location = 1) invariant highp out vec4 v_value;
void main ()
{
    mediump vec4 a = 1.0e4 * a_input.zzxx + a_input.xzxy - 1.0e4 * a_input.zzxx;
    mediump vec4 b = 1.0e4 * a_input.zzxx;
    mediump vec4 c = b - 1.0e4 * a_input.zzxx + a_input.xzxy;
    mediump vec4 d = (1.0e1 * a_input.yzxx) * (1.0e1 * a_input.yzzw) * (1.1*1.0e-1 * a_input.yzxx) * (1.0e-1 * a_input.xzzy);
    mediump vec4 e = ((1.0e1 * a_input.yzxx) * (1.1*1.0e-1 * a_input.yzxx)) * ((1.0e-1 * a_input.xzzy) * (1.0e1 * a_input.yzzw));
    v_unrelated = a + b + c + d + e;
    v_value = a_input + fract(c) + e;
    gl_Position = v_value;
}
