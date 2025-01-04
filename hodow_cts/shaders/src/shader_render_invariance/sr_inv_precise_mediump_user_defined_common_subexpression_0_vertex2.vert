#version 450
layout(location = 0) in mediump vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
layout(location = 1) precise highp out vec4 v_value;
void main ()
{
    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);
    v_value = a_input + (1.0e4*a_input.x*a_input.xxxx + 1.0e4*a_input.y*a_input.yyyy) * 1.0e-4;
    gl_Position = v_value;
}
