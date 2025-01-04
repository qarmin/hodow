#version 450
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};
#extension GL_EXT_geometry_point_size : require
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) in vec4 v_geom_pointSize[];
layout(location = 0) out vec4 v_frag_FragColor;
void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = v_geom_pointSize[0].x + 1.0;
    v_frag_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
}
