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
