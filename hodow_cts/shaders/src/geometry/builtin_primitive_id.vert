#version 450
out gl_PerVertex
 {
    vec4 gl_Position;
    float gl_PointSize;
};
layout(location = 0) in vec4 a_position;
layout(location = 1) in vec4 a_primitiveID;
layout(location = 0) out vec4 v_geom_primitiveID;
void main (void)
{
    gl_Position = a_position;
    v_geom_primitiveID = a_primitiveID;
}
