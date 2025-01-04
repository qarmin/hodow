#version 450
layout(location = 0) in lowp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
void main ()
{
    mediump vec2 unrelated0 = a_input.xz + vec2(0.1);
    mediump vec2 unrelated1 = unrelated0 + a_input.yx;
    mediump float unrelated2 = dot(unrelated0, unrelated1);
    v_unrelated = a_input + vec4(vec3(0.02 * unrelated2), 1.0);
    lowp vec2 used0 = a_input.xz + vec2(0.1);
    lowp vec2 used1 = used0 + a_input.yx;
    lowp precise float used2 = dot(used0, used1);
    gl_Position = a_input * vec4(vec3(0.3), 1.0) + used2;
}
