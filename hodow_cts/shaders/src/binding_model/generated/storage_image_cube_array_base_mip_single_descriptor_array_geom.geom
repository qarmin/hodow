#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0, rgba8) readonly uniform highp imageCubeArray u_image[2];
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 6));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 6));
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 6));
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image[0], ivec3(6, 13, 1));
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image[1], ivec3(19, 8, 8));
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image[0], ivec3(10, 26, 7));
    else
        result_color += imageLoad(u_image[1], ivec3(25, 25, 6));
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
