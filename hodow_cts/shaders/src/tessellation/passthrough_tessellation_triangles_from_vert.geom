#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=8) out;

layout(location = 0) in  highp vec4 v_vertex_color[];
layout(location = 0) out highp vec4 v_fragment_color;

void main (void)
{
    vec4 centerPos = (gl_in[0].gl_Position + gl_in[1].gl_Position + gl_in[2].gl_Position) / 3.0f;

    for (int ndx = 0; ndx < 4; ++ndx)
    {
        gl_Position = centerPos + (centerPos - gl_in[ndx % 3].gl_Position);
        v_fragment_color = v_vertex_color[ndx % 3];
        EmitVertex();

        gl_Position = centerPos + 0.7 * (centerPos - gl_in[ndx % 3].gl_Position);
        v_fragment_color = v_vertex_color[ndx % 3];
        EmitVertex();
    }
}
