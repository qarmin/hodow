#version 310 es

void main (void)
{
    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
    gl_PointSize = 2.0;
}
#version 310 es
layout(location = 0) out mediump vec4 fragColor;

void main (void)
{
    fragColor = vec4(1.0);
}
#version 310 es

void main (void)
{
    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require
layout(vertices = 1) out;

void main (void)
{
    gl_TessLevelOuter[0] = 3.0;
    gl_TessLevelOuter[1] = 3.0;
    gl_TessLevelOuter[2] = 3.0;
    gl_TessLevelInner[0] = 3.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require
layout(vertices = 1) out;

void main (void)
{
    gl_TessLevelOuter[0] = 3.0;
    gl_TessLevelOuter[1] = 3.0;
    gl_TessLevelOuter[2] = 3.0;
    gl_TessLevelInner[0] = 3.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    // pass as is to eval
    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
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

    // add to point size
    gl_PointSize = gl_in[0].gl_PointSize + 2.0;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_EXT_geometry_point_size : require
layout(points) in;
layout(points, max_vertices = 1) out;

void main (void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize + 2.0;

    EmitVertex();
}
