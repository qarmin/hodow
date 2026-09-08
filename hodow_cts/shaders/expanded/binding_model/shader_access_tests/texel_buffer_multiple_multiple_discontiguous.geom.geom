#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_EXT_texture_buffer : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) uniform highp readonly imageBuffer u_texelBuffer0A;
layout(set = 0, binding = 2, rgba8) uniform highp readonly imageBuffer u_texelBuffer0B;
layout(set = 1, binding = 0, rgba8) uniform highp readonly imageBuffer u_texelBuffer1A;
layout(set = 1, binding = 2, rgba8) uniform highp readonly imageBuffer u_texelBuffer1B;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_texelBuffer0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_texelBuffer0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_texelBuffer0A, 42);
    else
        result_color += imageLoad(u_texelBuffer0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_texelBuffer1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_texelBuffer1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_texelBuffer1A, 42);
    else
        result_color += imageLoad(u_texelBuffer1B, 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_texelBuffer0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_texelBuffer0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_texelBuffer0A, 42);
    else
        result_color += imageLoad(u_texelBuffer0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_texelBuffer1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_texelBuffer1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_texelBuffer1A, 42);
    else
        result_color += imageLoad(u_texelBuffer1B, 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_texelBuffer0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_texelBuffer0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_texelBuffer0A, 42);
    else
        result_color += imageLoad(u_texelBuffer0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_texelBuffer1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_texelBuffer1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_texelBuffer1A, 42);
    else
        result_color += imageLoad(u_texelBuffer1B, 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_texelBuffer0A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_texelBuffer0B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_texelBuffer0A, 42);
    else
        result_color += imageLoad(u_texelBuffer0B, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_texelBuffer1A, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_texelBuffer1B, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_texelBuffer1A, 42);
    else
        result_color += imageLoad(u_texelBuffer1B, 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
