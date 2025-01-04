#version 450
layout(location = 0) in highp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
void main ()
{
    mediump vec3 unrelated0 = a_input.xzy + vec3(0.1);
    mediump vec3 unrelated1 = unrelated0 + a_input.yxx;
    mediump vec3 unrelated2 = cross(unrelated0, unrelated1);
    v_unrelated = a_input + vec4(vec3(0.02 * unrelated2), 1.0);
    highp vec3 used0 = a_input.xzy + vec3(0.1);
    highp vec3 used1 = used0 + a_input.yxx;
    highp precise vec3 used2 = cross(used0, used1);
    gl_Position = a_input * vec4(vec3(0.3), 1.0) + vec4(used2, 0.0);
}
