#version 310 es
#extension GL_EXT_geometry_shader : require
layout(lines) in;
layout(line_strip, max_vertices=11) out;

layout(location = 0) in  highp vec4 v_vertex_color[];
layout(location = 0) out highp vec4 v_fragment_color;

void main (void)
{
    vec4 mdir = vec4(gl_in[0].gl_Position.y - gl_in[1].gl_Position.y, gl_in[1].gl_Position.x - gl_in[0].gl_Position.x, 0.0, 0.0);
    for (int i = 0; i <= 10; ++i)
    {
        float xweight = cos(float(i) / 10.0 * 6.28) * 0.5 + 0.5;
        float mweight = sin(float(i) / 10.0 * 6.28) * 0.1 + 0.1;
        gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, xweight) + mweight * mdir;
        v_fragment_color = mix(v_vertex_color[0], v_vertex_color[1], xweight);
        EmitVertex();
    }
}
