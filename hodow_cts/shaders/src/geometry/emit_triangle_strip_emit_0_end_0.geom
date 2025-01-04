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
