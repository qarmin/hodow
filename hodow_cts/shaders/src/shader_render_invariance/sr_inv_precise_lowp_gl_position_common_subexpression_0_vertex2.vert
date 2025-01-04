#version 450
layout(location = 0) in lowp vec4 a_input;
layout(location = 0) out mediump vec4 v_unrelated;
precise gl_Position;
void main ()
{
    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);
    gl_Position = a_input + (0.9*a_input.x*a_input.xxxx + 0.9*a_input.y*a_input.yyyy) * 1.1;
    
}
