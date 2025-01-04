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
