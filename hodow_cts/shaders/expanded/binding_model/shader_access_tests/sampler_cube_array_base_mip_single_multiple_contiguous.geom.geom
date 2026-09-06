#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(triangle_strip, max_vertices=4) out;
layout(set = 0, binding = 0) uniform highp textureCubeArray u_separateTexture;
layout(set = 0, binding = 1) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 1) flat in highp int geo_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp int quadrant_id;
    highp vec4 result_color;

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerA), vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerB), vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerA), vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerB), vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[1];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerA), vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerB), vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerA), vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerB), vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    quadrant_id = geo_quadrant_id[2];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerA), vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerB), vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerA), vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerB), vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5;
    EmitVertex();

    quadrant_id = geo_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerA), vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerB), vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerA), vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(samplerCubeArray(u_separateTexture, u_separateSamplerB), vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    frag_color = result_color;
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
