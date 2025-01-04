#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_color;
layout(location = 0) out highp vec4 v_geom_FragColor;
void main (void)
{
    gl_Position = a_position;
    v_geom_FragColor = a_color;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(points, max_vertices = 3) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;

void main (void)
{
    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);
    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);
    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);
    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);

    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)
    {
        gl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();
        EndPrimitive();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_EXT_geometry_point_size : require
layout(points) in;
layout(points, max_vertices = 3) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;

void main (void)
{
    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);
    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);
    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);
    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);

    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)
    {
        gl_PointSize = 1.0;
        gl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_PointSize = 1.0;
        gl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_PointSize = 1.0;
        gl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();
        EndPrimitive();
    }
}
#version 310 es
layout(location = 0) out highp vec4 fragColor;
layout(location = 0) in highp vec4 v_frag_FragColor;
void main (void)
{
    fragColor = v_frag_FragColor;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(lines) in;
layout(line_strip, max_vertices = 6) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;

void main (void)
{
    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);
    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);
    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);
    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);

    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)
    {
        gl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();
        EndPrimitive();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 9) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;

void main (void)
{
    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);
    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);
    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);
    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);

    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)
    {
        gl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();
        EndPrimitive();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(lines_adjacency) in;
layout(line_strip, max_vertices = 12) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;

void main (void)
{
    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);
    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);
    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);
    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);

    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)
    {
        gl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();
        EndPrimitive();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles_adjacency) in;
layout(triangle_strip, max_vertices = 18) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;

void main (void)
{
    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);
    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);
    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);
    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);

    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)
    {
        gl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();
        EndPrimitive();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(points, max_vertices = 9) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;

void main (void)
{
    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);
    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);
    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);
    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);

    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)
    {
        gl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();
        EndPrimitive();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_EXT_geometry_point_size : require
layout(triangles) in;
layout(points, max_vertices = 9) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;

void main (void)
{
    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);
    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);
    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);
    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);

    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)
    {
        gl_PointSize = 1.0;
        gl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_PointSize = 1.0;
        gl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_PointSize = 1.0;
        gl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();
        EndPrimitive();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(lines) in;
layout(points, max_vertices = 6) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;

void main (void)
{
    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);
    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);
    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);
    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);

    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)
    {
        gl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();
        EndPrimitive();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_EXT_geometry_point_size : require
layout(lines) in;
layout(points, max_vertices = 6) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;

void main (void)
{
    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);
    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);
    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);
    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);

    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)
    {
        gl_PointSize = 1.0;
        gl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_PointSize = 1.0;
        gl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_PointSize = 1.0;
        gl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();
        EndPrimitive();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(line_strip, max_vertices = 3) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;

void main (void)
{
    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);
    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);
    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);
    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);

    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)
    {
        gl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();
        EndPrimitive();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(line_strip, max_vertices = 9) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;

void main (void)
{
    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);
    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);
    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);
    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);

    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)
    {
        gl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();
        EndPrimitive();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(triangle_strip, max_vertices = 3) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;

void main (void)
{
    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);
    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);
    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);
    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);

    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)
    {
        gl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();
        EndPrimitive();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(lines) in;
layout(triangle_strip, max_vertices = 6) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;

void main (void)
{
    const highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);
    const highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);
    const highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);
    highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);

    for (highp int ndx = 0; ndx < gl_in.length(); ndx++)
    {
        gl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();

        gl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;
        v_frag_FragColor = v_geom_FragColor[ndx];
        EmitVertex();
        EndPrimitive();
    }
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_color;
void main (void)
{
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;
layout(location = 0) out highp vec4 v_frag_0;
void main (void)
{
    highp vec4 offset = vec4(-0.2, -0.2, 0.0, 0.0);
    highp vec4 inputColor;

    inputColor = vec4(1.0, 0.0, 0.0, 1.0);
    gl_Position = vec4(0.0, 0.0, 0.0, 1.0) + offset;
    v_frag_0 = inputColor;
    EmitVertex();

    inputColor = vec4(1.0, 0.0, 0.0, 1.0);
    gl_Position = vec4(1.0, 0.0, 0.0, 1.0) + offset;
    v_frag_0 = inputColor;
    EmitVertex();

    inputColor = vec4(1.0, 0.0, 0.0, 1.0);
    gl_Position = vec4(1.0, 1.0, 0.0, 1.0) + offset;
    v_frag_0 = inputColor;
    EmitVertex();

    EndPrimitive();
}
#version 310 es
layout(location = 0) out highp vec4 fragColor;
layout(location = 0) in highp vec4 v_frag_0;
void main (void)
{
    fragColor = v_frag_0;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_color;
void main (void)
{
    gl_Position = a_position;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;
layout(location = 0) out highp vec4 v_frag_0;
void main (void)
{
    highp vec4 offset = vec4(-0.2, -0.2, 0.0, 0.0);
    highp vec4 inputColor;

    inputColor = vec4(1.0, 0.0, 0.0, 1.0);
    gl_Position = gl_in[0].gl_Position + offset;
    v_frag_0 = inputColor;
    EmitVertex();

    inputColor = vec4(1.0, 0.0, 0.0, 1.0);
    gl_Position = gl_in[1].gl_Position + offset;
    v_frag_0 = inputColor;
    EmitVertex();

    inputColor = vec4(1.0, 0.0, 0.0, 1.0);
    gl_Position = gl_in[2].gl_Position + offset;
    v_frag_0 = inputColor;
    EmitVertex();

    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;
layout(location = 0) out highp vec4 v_frag_0;
layout(location = 1) out highp vec4 v_frag_1;
void main (void)
{
    highp vec4 offset = vec4(-0.2, -0.2, 0.0, 0.0);
    highp vec4 inputColor;

    inputColor = vec4(1.0, 0.0, 0.0, 1.0);
    gl_Position = gl_in[0].gl_Position + offset;
    v_frag_0 = inputColor * 0.5;
    v_frag_1 = inputColor.yxzw * 0.5;
    EmitVertex();

    inputColor = vec4(1.0, 0.0, 0.0, 1.0);
    gl_Position = gl_in[1].gl_Position + offset;
    v_frag_0 = inputColor * 0.5;
    v_frag_1 = inputColor.yxzw * 0.5;
    EmitVertex();

    inputColor = vec4(1.0, 0.0, 0.0, 1.0);
    gl_Position = gl_in[2].gl_Position + offset;
    v_frag_0 = inputColor * 0.5;
    v_frag_1 = inputColor.yxzw * 0.5;
    EmitVertex();

    EndPrimitive();
}
#version 310 es
layout(location = 0) out highp vec4 fragColor;
layout(location = 0) in highp vec4 v_frag_0;
layout(location = 1) in highp vec4 v_frag_1;
void main (void)
{
    fragColor = v_frag_0 + v_frag_1.yxzw;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_color;
layout(location = 0) out highp vec4 v_geom_0;
void main (void)
{
    gl_Position = a_position;
    v_geom_0 = a_color;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;
layout(location = 0) in highp vec4 v_geom_0[];
void main (void)
{
    highp vec4 offset = vec4(-0.2, -0.2, 0.0, 0.0);
    highp vec4 inputColor;

    inputColor = v_geom_0[0];
    gl_Position = gl_in[0].gl_Position + offset;
    EmitVertex();

    inputColor = v_geom_0[1];
    gl_Position = gl_in[1].gl_Position + offset;
    EmitVertex();

    inputColor = v_geom_0[2];
    gl_Position = gl_in[2].gl_Position + offset;
    EmitVertex();

    EndPrimitive();
}
#version 310 es
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
fragColor = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;
layout(location = 0) in highp vec4 v_geom_0[];
layout(location = 0) out highp vec4 v_frag_0;
layout(location = 1) out highp vec4 v_frag_1;
void main (void)
{
    highp vec4 offset = vec4(-0.2, -0.2, 0.0, 0.0);
    highp vec4 inputColor;

    inputColor = v_geom_0[0];
    gl_Position = gl_in[0].gl_Position + offset;
    v_frag_0 = inputColor * 0.5;
    v_frag_1 = inputColor.yxzw * 0.5;
    EmitVertex();

    inputColor = v_geom_0[1];
    gl_Position = gl_in[1].gl_Position + offset;
    v_frag_0 = inputColor * 0.5;
    v_frag_1 = inputColor.yxzw * 0.5;
    EmitVertex();

    inputColor = v_geom_0[2];
    gl_Position = gl_in[2].gl_Position + offset;
    v_frag_0 = inputColor * 0.5;
    v_frag_1 = inputColor.yxzw * 0.5;
    EmitVertex();

    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_EXT_geometry_point_size : require
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
}
#version 310 es
layout(location = 0) out mediump vec4 fragColor;
layout(location = 0) in highp vec4 v_frag_FragColor;
void main (void)
{
    fragColor = v_frag_FragColor;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_EXT_geometry_point_size : require
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(points, max_vertices = 2) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_EXT_geometry_point_size : require
layout(points) in;
layout(points, max_vertices = 2) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_PointSize = 1.0;
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    EndPrimitive();
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_EXT_geometry_point_size : require
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    EndPrimitive();
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(points, max_vertices = 2) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_EXT_geometry_point_size : require
layout(points) in;
layout(points, max_vertices = 2) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_PointSize = 1.0;
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(line_strip, max_vertices = 1) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(line_strip, max_vertices = 1) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(line_strip, max_vertices = 2) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(line_strip, max_vertices = 3) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    gl_Position = gl_in[0].gl_Position + position1;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(line_strip, max_vertices = 1) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    EndPrimitive();
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(line_strip, max_vertices = 2) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(line_strip, max_vertices = 3) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    gl_Position = gl_in[0].gl_Position + position1;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(line_strip, max_vertices = 5) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    gl_Position = gl_in[0].gl_Position + position1;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
    EndPrimitive();
    gl_Position = gl_in[0].gl_Position + position2;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    gl_Position = gl_in[0].gl_Position + position3;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(triangle_strip, max_vertices = 1) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(triangle_strip, max_vertices = 1) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(triangle_strip, max_vertices = 2) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(triangle_strip, max_vertices = 3) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    gl_Position = gl_in[0].gl_Position + position1;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(triangle_strip, max_vertices = 4) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    gl_Position = gl_in[0].gl_Position + position1;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    gl_Position = gl_in[0].gl_Position + position2;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(triangle_strip, max_vertices = 1) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    EndPrimitive();
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(triangle_strip, max_vertices = 2) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(triangle_strip, max_vertices = 3) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    gl_Position = gl_in[0].gl_Position + position1;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(triangle_strip, max_vertices = 4) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    gl_Position = gl_in[0].gl_Position + position1;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    gl_Position = gl_in[0].gl_Position + position2;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
    EndPrimitive();
}
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(points) in;
layout(triangle_strip, max_vertices = 7) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
void main (void)
{
    const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);
    const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);
    const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);
    const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);
    const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);
    const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position + position0;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    gl_Position = gl_in[0].gl_Position + position1;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    gl_Position = gl_in[0].gl_Position + position2;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    EndPrimitive();
    EndPrimitive();
    gl_Position = gl_in[0].gl_Position + position3;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    gl_Position = gl_in[0].gl_Position + position4;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

    gl_Position = gl_in[0].gl_Position + position5;
    gl_PrimitiveID = gl_PrimitiveIDIn;
    v_frag_FragColor = v_geom_FragColor[0];
    EmitVertex();

}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_storage_multisample_2d_array : require
layout(points) in;
layout(triangle_strip, max_vertices = 10) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void)
{
    const highp float rowHeight = 2.0 / float(1);
    const highp float colWidth = 2.0 / float(10);
    highp int emitCount = 10;
    for (highp int ndx = 0; ndx < emitCount / 2; ndx++)
    {
        gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, 0.0, 0.0, 0.0);
        v_frag_FragColor = v_geom_FragColor[0];
        EmitVertex();
        gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, rowHeight, 0.0, 0.0);
        v_frag_FragColor = v_geom_FragColor[0];
        EmitVertex();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_storage_multisample_2d_array : require
layout(points) in;
layout(triangle_strip, max_vertices = 128) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void)
{
    const highp float rowHeight = 2.0 / float(1);
    const highp float colWidth = 2.0 / float(128);
    highp int emitCount = 128;
    for (highp int ndx = 0; ndx < emitCount / 2; ndx++)
    {
        gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, 0.0, 0.0, 0.0);
        v_frag_FragColor = v_geom_FragColor[0];
        EmitVertex();
        gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, rowHeight, 0.0, 0.0);
        v_frag_FragColor = v_geom_FragColor[0];
        EmitVertex();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_storage_multisample_2d_array : require
layout(points) in;
layout(triangle_strip, max_vertices = 100) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void)
{
    const highp float rowHeight = 2.0 / float(2);
    const highp float colWidth = 2.0 / float(100);
    highp int emitCount = (gl_PrimitiveIDIn == 0) ? (10) : (100);
    for (highp int ndx = 0; ndx < emitCount / 2; ndx++)
    {
        gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, 0.0, 0.0, 0.0);
        v_frag_FragColor = v_geom_FragColor[0];
        EmitVertex();
        gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, rowHeight, 0.0, 0.0);
        v_frag_FragColor = v_geom_FragColor[0];
        EmitVertex();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_storage_multisample_2d_array : require
layout(points) in;
layout(triangle_strip, max_vertices = 100) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void)
{
    const highp float rowHeight = 2.0 / float(2);
    const highp float colWidth = 2.0 / float(100);
    highp int emitCount = (gl_PrimitiveIDIn == 0) ? (100) : (10);
    for (highp int ndx = 0; ndx < emitCount / 2; ndx++)
    {
        gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, 0.0, 0.0, 0.0);
        v_frag_FragColor = v_geom_FragColor[0];
        EmitVertex();
        gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, rowHeight, 0.0, 0.0);
        v_frag_FragColor = v_geom_FragColor[0];
        EmitVertex();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_storage_multisample_2d_array : require
layout(points) in;
layout(triangle_strip, max_vertices = 128) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void)
{
    const highp float rowHeight = 2.0 / float(2);
    const highp float colWidth = 2.0 / float(128);
    highp int emitCount = (gl_PrimitiveIDIn == 0) ? (0) : (128);
    for (highp int ndx = 0; ndx < emitCount / 2; ndx++)
    {
        gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, 0.0, 0.0, 0.0);
        v_frag_FragColor = v_geom_FragColor[0];
        EmitVertex();
        gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, rowHeight, 0.0, 0.0);
        v_frag_FragColor = v_geom_FragColor[0];
        EmitVertex();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_storage_multisample_2d_array : require
layout(points) in;
layout(triangle_strip, max_vertices = 128) out;
layout(location = 0) in highp vec4 v_geom_FragColor[];
layout(location = 0) out highp vec4 v_frag_FragColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void)
{
    const highp float rowHeight = 2.0 / float(2);
    const highp float colWidth = 2.0 / float(128);
    highp int emitCount = (gl_PrimitiveIDIn == 0) ? (128) : (0);
    for (highp int ndx = 0; ndx < emitCount / 2; ndx++)
    {
        gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, 0.0, 0.0, 0.0);
        v_frag_FragColor = v_geom_FragColor[0];
        EmitVertex();
        gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, rowHeight, 0.0, 0.0);
        v_frag_FragColor = v_geom_FragColor[0];
        EmitVertex();
    }
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_emitCount;
layout(location = 0) out highp vec4 v_geom_emitCount;
void main (void)
{
    gl_Position = a_position;
    v_geom_emitCount = a_emitCount;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_storage_multisample_2d_array : require
layout(points) in;
layout(triangle_strip, max_vertices = 128) out;
layout(location = 0) in highp vec4 v_geom_emitCount[];
layout(location = 0) out highp vec4 v_frag_FragColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void)
{
    highp vec4 attrEmitCounts = v_geom_emitCount[0];
    mediump int emitCount = int(attrEmitCounts[0]);
    highp vec4 color = vec4((emitCount < 10) ? (0.0) : (1.0), (emitCount > 10) ? (0.0) : (1.0), 1.0, 1.0);
    highp vec4 basePos = gl_in[0].gl_Position;
    for (mediump int i = 0; i < emitCount / 2; i++)
    {
        highp float angle = (float(i) + 0.5) / float(emitCount / 2) * 3.142;
        gl_Position = basePos + vec4(cos(angle),  sin(angle), 0.0, 0.0) * 0.15;
        v_frag_FragColor = color;
        EmitVertex();
        gl_Position = basePos + vec4(cos(angle), -sin(angle), 0.0, 0.0) * 0.15;
        v_frag_FragColor = color;
        EmitVertex();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_storage_multisample_2d_array : require
layout(points, invocations=4) in;
layout(triangle_strip, max_vertices = 128) out;
layout(location = 0) in highp vec4 v_geom_emitCount[];
layout(location = 0) out highp vec4 v_frag_FragColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void)
{
    highp vec4 attrEmitCounts = v_geom_emitCount[0];
    mediump int emitCount = int(attrEmitCounts[gl_InvocationID]);
    highp vec4 color = vec4((emitCount < 10) ? (0.0) : (1.0), (emitCount > 10) ? (0.0) : (1.0), 1.0, 1.0);
    highp vec4 basePos = gl_in[0].gl_Position + 0.5 * vec4(cos(float(gl_InvocationID)), sin(float(gl_InvocationID)), 0.0, 0.0);
    for (mediump int i = 0; i < emitCount / 2; i++)
    {
        highp float angle = (float(i) + 0.5) / float(emitCount / 2) * 3.142;
        gl_Position = basePos + vec4(cos(angle),  sin(angle), 0.0, 0.0) * 0.15;
        v_frag_FragColor = color;
        EmitVertex();
        gl_Position = basePos + vec4(cos(angle), -sin(angle), 0.0, 0.0) * 0.15;
        v_frag_FragColor = color;
        EmitVertex();
    }
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_vertexNdx;
layout(location = 0) out highp vec4 v_geom_vertexNdx;
void main (void)
{
    gl_Position = a_position;
    v_geom_vertexNdx = a_vertexNdx;
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_storage_multisample_2d_array : require
layout(points) in;
layout(triangle_strip, max_vertices = 128) out;
layout(location = 0) in highp vec4 v_geom_vertexNdx[];
layout(binding = 0) readonly uniform Input {
    ivec4 u_emitCount;
} emit;
layout(location = 0) out highp vec4 v_frag_FragColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void)
{
    mediump int primitiveNdx = int(v_geom_vertexNdx[0].x);
    mediump int emitCount = emit.u_emitCount[primitiveNdx];

    const highp vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    const highp vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
    const highp vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);
    const highp vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);
    const highp vec4 colors[4] = vec4[4](red, green, blue, yellow);
    highp vec4 color = colors[int(primitiveNdx)];

    highp vec4 basePos = gl_in[0].gl_Position;
    for (mediump int i = 0; i < emitCount / 2; i++)
    {
        highp float angle = (float(i) + 0.5) / float(emitCount / 2) * 3.142;
        gl_Position = basePos + vec4(cos(angle),  sin(angle), 0.0, 0.0) * 0.15;
        v_frag_FragColor = color;
        EmitVertex();
        gl_Position = basePos + vec4(cos(angle), -sin(angle), 0.0, 0.0) * 0.15;
        v_frag_FragColor = color;
        EmitVertex();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_storage_multisample_2d_array : require
layout(points, invocations=4) in;
layout(triangle_strip, max_vertices = 128) out;
layout(location = 0) in highp vec4 v_geom_vertexNdx[];
layout(binding = 0) readonly uniform Input {
    ivec4 u_emitCount;
} emit;
layout(location = 0) out highp vec4 v_frag_FragColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void)
{
    mediump int primitiveNdx = gl_InvocationID;
    mediump int emitCount = emit.u_emitCount[primitiveNdx];

    const highp vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    const highp vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
    const highp vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);
    const highp vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);
    const highp vec4 colors[4] = vec4[4](red, green, blue, yellow);
    highp vec4 color = colors[int(primitiveNdx)];

    highp vec4 basePos = gl_in[0].gl_Position + 0.5 * vec4(cos(float(gl_InvocationID)), sin(float(gl_InvocationID)), 0.0, 0.0);
    for (mediump int i = 0; i < emitCount / 2; i++)
    {
        highp float angle = (float(i) + 0.5) / float(emitCount / 2) * 3.142;
        gl_Position = basePos + vec4(cos(angle),  sin(angle), 0.0, 0.0) * 0.15;
        v_frag_FragColor = color;
        EmitVertex();
        gl_Position = basePos + vec4(cos(angle), -sin(angle), 0.0, 0.0) * 0.15;
        v_frag_FragColor = color;
        EmitVertex();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_storage_multisample_2d_array : require
layout(points) in;
layout(triangle_strip, max_vertices = 128) out;
layout(location = 0) in highp vec4 v_geom_vertexNdx[];
layout(binding = 0) uniform highp sampler2D u_sampler;
layout(location = 0) out highp vec4 v_frag_FragColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void)
{
    highp float primitiveNdx = v_geom_vertexNdx[0].x;
    highp vec2 texCoord = vec2(1.0 / 8.0 + primitiveNdx / 4.0, 0.5);
    highp vec4 texColor = texture(u_sampler, texCoord);
    mediump int emitCount = 0;
    if (texColor.x > 0.0)
        emitCount += 6;
    if (texColor.y > 0.0)
        emitCount += 0;
    if (texColor.z > 0.0)
        emitCount += 128;
    if (texColor.w > 0.0)
        emitCount += 10;
    const highp vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    const highp vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
    const highp vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);
    const highp vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);
    const highp vec4 colors[4] = vec4[4](red, green, blue, yellow);
    highp vec4 color = colors[int(primitiveNdx)];
    highp vec4 basePos = gl_in[0].gl_Position;
    for (mediump int i = 0; i < emitCount / 2; i++)
    {
        highp float angle = (float(i) + 0.5) / float(emitCount / 2) * 3.142;
        gl_Position = basePos + vec4(cos(angle),  sin(angle), 0.0, 0.0) * 0.15;
        v_frag_FragColor = color;
        EmitVertex();
        gl_Position = basePos + vec4(cos(angle), -sin(angle), 0.0, 0.0) * 0.15;
        v_frag_FragColor = color;
        EmitVertex();
    }
}
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_storage_multisample_2d_array : require
layout(points, invocations=4) in;
layout(triangle_strip, max_vertices = 128) out;
layout(location = 0) in highp vec4 v_geom_vertexNdx[];
layout(binding = 0) uniform highp sampler2D u_sampler;
layout(location = 0) out highp vec4 v_frag_FragColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void)
{
    highp float primitiveNdx = float(gl_InvocationID);
    highp vec2 texCoord = vec2(1.0 / 8.0 + primitiveNdx / 4.0, 0.5);
    highp vec4 texColor = texture(u_sampler, texCoord);
    mediump int emitCount = 0;
    if (texColor.x > 0.0)
        emitCount += 6;
    if (texColor.y > 0.0)
        emitCount += 0;
    if (texColor.z > 0.0)
        emitCount += 128;
    if (texColor.w > 0.0)
        emitCount += 10;
    const highp vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    const highp vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
    const highp vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);
    const highp vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);
    const highp vec4 colors[4] = vec4[4](red, green, blue, yellow);
    highp vec4 color = colors[int(primitiveNdx)];
    highp vec4 basePos = gl_in[0].gl_Position + 0.5 * vec4(cos(float(gl_InvocationID)), sin(float(gl_InvocationID)), 0.0, 0.0);
    for (mediump int i = 0; i < emitCount / 2; i++)
    {
        highp float angle = (float(i) + 0.5) / float(emitCount / 2) * 3.142;
        gl_Position = basePos + vec4(cos(angle),  sin(angle), 0.0, 0.0) * 0.15;
        v_frag_FragColor = color;
        EmitVertex();
        gl_Position = basePos + vec4(cos(angle), -sin(angle), 0.0, 0.0) * 0.15;
        v_frag_FragColor = color;
        EmitVertex();
    }
}
#version 460
out gl_PerVertex {
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
void main(void) {
    gl_Position = inPos;
}
#version 460
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex {
    vec4 gl_Position;
} gl_in[3];
out gl_PerVertex {
    vec4 gl_Position;
};
layout (set=0, binding=0, std430) buffer SSBO_Block {
    uint condition;
    uint value;
} ssbo;
void main() {
    ssbo.value = 777u;
    if (ssbo.condition != 0u) {
        for (uint i = 0; i < 3; ++i) {
            gl_Position = gl_in[i].gl_Position;
            EmitVertex();
        }
        EndPrimitive();
    }
}
#version 460
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex {
    vec4 gl_Position;
} gl_in[3];
out gl_PerVertex {
    vec4 gl_Position;
};
layout (set=0, binding=0, std430) buffer SSBO_Block {
    uint condition;
    uint value;
} ssbo;
void main() {
    ssbo.value = 777u;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();
    EndPrimitive();
}
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
#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in vec4 v_frag_FragColor;
void main (void)
{
    fragColor = v_frag_FragColor;
}
#version 450
out gl_PerVertex
 {
    vec4 gl_Position;
    float gl_PointSize;
};
layout(location = 0) in vec4 a_position;
void main (void)
{
    gl_Position = a_position;
}
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
layout(lines) in;
layout(triangle_strip, max_vertices = 10) out;
layout(location = 0) out vec4 v_frag_FragColor;
void main (void)
{
    const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    const vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
    const vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);
    const vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);
    const vec4 colors[4] = vec4[4](red, green, blue, yellow);
    for (int counter = 0; counter < 3; ++counter)
    {
        float percent = 0.1 * counter;
        gl_Position = gl_in[0].gl_Position * vec4(1.0 + percent, 1.0 + percent, 1.0, 1.0);
        v_frag_FragColor = colors[gl_PrimitiveIDIn % 4];
        EmitVertex();
        gl_Position = gl_in[1].gl_Position * vec4(1.0 + percent, 1.0 + percent, 1.0, 1.0);
        v_frag_FragColor = colors[gl_PrimitiveIDIn % 4];
        EmitVertex();
    }
}
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
layout(points, invocations=1) in;
layout(triangle_strip, max_vertices = 3) out;
layout(location = 0) in vec4 v_geom_primitiveID[];
void main (void)
{
    gl_Position = gl_in[0].gl_Position + vec4(0.05, 0.0, 0.0, 0.0);
    gl_PrimitiveID = int(floor(v_geom_primitiveID[0].x)) + 3;
    EmitVertex();
    gl_Position = gl_in[0].gl_Position - vec4(0.05, 0.0, 0.0, 0.0);
    gl_PrimitiveID = int(floor(v_geom_primitiveID[0].x)) + 3;
    EmitVertex();
    gl_Position = gl_in[0].gl_Position + vec4(0.0, 0.05, 0.0, 0.0);
    gl_PrimitiveID = int(floor(v_geom_primitiveID[0].x)) + 3;
    EmitVertex();
}
#version 450
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    const vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
    const vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);
    const vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);
    const vec4 colors[4] = vec4[4](yellow, red, green, blue);
    fragColor = colors[gl_PrimitiveID % 4];
}
#version 450
out gl_PerVertex
 {
    vec4 gl_Position;
    float gl_PointSize;
};
layout(location = 0) in vec4 a_position;
layout(location = 0) out vec4 v_position;
void main (void)
{
    v_position = a_position;
    gl_Position = a_position;
}
struct VSOut
{
    float4 Position : SV_POSITION;
};
[maxvertexcount(10)]
void main(triangle VSOut input[3], inout TriangleStream<VSOut> TriStream)
{
    VSOut output;
    output.Position = input[0].Position;
    TriStream.Append(output);
    output.Position = input[1].Position;
    TriStream.Append(output);
    output.Position = input[2].Position;
    TriStream.Append(output);
}
#version 450
layout(location = 0) out vec4 fragColor;
void main (void)
{
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);;
}
