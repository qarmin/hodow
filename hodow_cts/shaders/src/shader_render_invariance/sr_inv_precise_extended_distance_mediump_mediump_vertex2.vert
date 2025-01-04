#version 450
layout(location = 0) in mediump vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
void main ()
{
    v_unrelated = vec4(0.0);
    mediump vec2 used0 = a_input.xz + vec2(0.1);
    mediump vec2 used1 = used0 + a_input.yx;
    mediump precise float used2 = distance(used0, used1);
    gl_Position = a_input * vec4(vec3(0.3), 1.0) + used2;
}
