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
