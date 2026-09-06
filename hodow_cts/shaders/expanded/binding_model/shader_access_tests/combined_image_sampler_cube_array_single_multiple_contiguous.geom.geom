#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSamplerA;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSamplerA, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSamplerB, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
