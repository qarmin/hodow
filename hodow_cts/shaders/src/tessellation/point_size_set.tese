#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require
layout(triangles, point_mode) in;

void main (void)
{
    // hide all but one vertex
    if (gl_TessCoord.x < 0.99)
        gl_Position = vec4(-2.0, 0.0, 0.0, 1.0);
    else
        gl_Position = gl_in[0].gl_Position;

    // set point size
    gl_PointSize = 4.0;
}
