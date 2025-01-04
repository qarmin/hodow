#version 450
layout(location = 0) in highp vec4 a_position;
out gl_PerVertex {
    vec4 gl_Position;
};
layout(location = 1) in highp vec4 a_color;
layout(location = 0) out highp vec4 v_color;
void main (void)
{
    gl_Position = a_position;
    v_color = a_color;
}
