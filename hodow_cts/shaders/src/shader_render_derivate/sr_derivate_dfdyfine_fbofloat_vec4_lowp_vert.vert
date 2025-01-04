#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in lowp vec4 a_coord;
layout(location = 0) out lowp vec4 v_coord;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
    v_coord = a_coord;
}
