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
