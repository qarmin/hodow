#version 450
layout(location = 0) in highp vec4 a_input;
layout(location = 0) out highp vec4 v_unrelated;
precise gl_Position;
void main ()
{
    highp float unrelated0 = a_input.x + 0.1;
    highp float unrelated1 = unrelated0 + a_input.y;
    highp float unrelated2 = mix(unrelated0, unrelated1, a_input.z);
    v_unrelated = a_input + vec4(vec3(0.02 * unrelated2), 1.0);
    highp float used0 = a_input.x + 0.1;
    highp float used1 = used0 + a_input.y;
    highp precise float used2 = mix(used0, used1, a_input.z);
    gl_Position = a_input * vec4(vec3(0.3), 1.0) + used2;
}
