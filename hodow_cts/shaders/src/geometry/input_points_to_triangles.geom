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
