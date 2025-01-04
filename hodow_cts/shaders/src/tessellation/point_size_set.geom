#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_EXT_geometry_point_size : require
layout(points) in;
layout(points, max_vertices = 1) out;

void main (void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = 6.0;

    EmitVertex();
}
