#version 450
layout(location = 0) in highp vec4 a_input;
layout(location = 0) out lowp vec4 v_unrelated;
precise gl_Position;
layout(location = 1) precise highp out vec4 v_value;
void main ()
{
    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);
    highp vec4 used0 = a_input + vec4(0.1, 0.2, 0.3, 0.4);
    highp vec4 used1 = vec4(0.8, 0.4, -0.2, 0.3) * used0.xywz + used0;
    highp vec4 used2 = refract(used1, used0, distance(used0, used1));
    v_value = a_input + 0.02 * vec4(fract(used2).xyz, 0.0);
    gl_Position = v_value;
}
