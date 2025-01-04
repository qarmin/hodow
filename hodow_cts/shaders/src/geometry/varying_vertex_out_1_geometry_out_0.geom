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
