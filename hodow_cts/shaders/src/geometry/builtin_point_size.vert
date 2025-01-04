#version 450
out gl_PerVertex
 {
    vec4 gl_Position;
    float gl_PointSize;
};
layout(location = 0) in vec4 a_position;
layout(location = 1) in vec4 a_pointSize;
layout(location = 0) out vec4 v_geom_pointSize;
void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
    v_geom_pointSize = a_pointSize;
}
