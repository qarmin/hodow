#version 450
layout(location = 0) in lowp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
invariant gl_Position;
void main ()
{
    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);
    lowp vec4 used0 = a_input + vec4(0.1, 0.2, 0.3, 0.4);
    lowp vec4 used1 = vec4(0.8, 0.4, -0.2, 0.3) * used0.xywz + used0;
    lowp vec4 used2 = refract(used1, used0, distance(used0, used1));
    gl_Position = a_input + 0.02 * vec4(fract(used2).xyz, 0.0);
    
}
