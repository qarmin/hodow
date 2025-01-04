#version 450
layout(location = 0) in lowp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
invariant gl_Position;
layout(location = 1) invariant highp out vec4 v_value;
void main ()
{
    v_unrelated = a_input.xzxz + (0.9*a_input.x*a_input.xxxx + 0.9*a_input.y*a_input.yyyy) * (1.08 * a_input.zyzy * a_input.xzxz) * 1.1 * (a_input.z * a_input.zzxz - a_input.z * a_input.zzxz) + (0.9*a_input.x*a_input.xxxx + 0.9*a_input.y*a_input.yyyy) / 0.9;
    v_value = a_input + (0.9*a_input.x*a_input.xxxx + 0.9*a_input.y*a_input.yyyy) * 1.1;
    gl_Position = v_value;
}
