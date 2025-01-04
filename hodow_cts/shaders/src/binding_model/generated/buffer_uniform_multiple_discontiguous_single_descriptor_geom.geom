#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, std140) uniform BufferName0
{
    highp vec4 colorA;
    highp vec4 colorB;
} b_instance0;
layout(set = 2, binding = 0, std140) uniform BufferName1
{
    highp vec4 colorA;
    highp vec4 colorB;
} b_instance1;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color += b_instance0.colorA;
    else
        result_color += b_instance0.colorB;
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color += b_instance1.colorA;
    else
        result_color += b_instance1.colorB;
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color += b_instance0.colorA;
    else
        result_color += b_instance0.colorB;
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color += b_instance1.colorA;
    else
        result_color += b_instance1.colorB;
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color += b_instance0.colorA;
    else
        result_color += b_instance0.colorB;
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color += b_instance1.colorA;
    else
        result_color += b_instance1.colorB;
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color += b_instance0.colorA;
    else
        result_color += b_instance0.colorB;
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color += b_instance1.colorA;
    else
        result_color += b_instance1.colorB;
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
