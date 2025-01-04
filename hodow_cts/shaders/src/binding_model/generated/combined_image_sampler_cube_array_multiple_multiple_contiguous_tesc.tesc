#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(vertices=3) out;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp samplerCubeArray u_combinedTextureSampler1B;
layout(location = 1) flat in highp int tsc_quadrant_id[];
layout(location = 0) out highp vec4 tes_color[];
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0A, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0B, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0A, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0B, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1A, vec4(float(-0.976562), float(-0.984375), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1B, vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1A, vec4(float(-1), float(-0.359375), float(-0.664062), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1B, vec4(float(1), float(-0.648438), float(-0.382812), float(1)), 0.0);
    result_color /= vec4(2.0);

    tes_color[gl_InvocationID] = result_color;

    // no dynamic input block indexing
    highp vec4 position;
    if (gl_InvocationID == 0)
        position = gl_in[0].gl_Position;
    else if (gl_InvocationID == 1)
        position = gl_in[1].gl_Position;
    else
        position = gl_in[2].gl_Position;
    gl_out[gl_InvocationID].gl_Position = position;
    gl_TessLevelInner[0] = 2.8;
    gl_TessLevelInner[1] = 2.8;
    gl_TessLevelOuter[0] = 2.8;
    gl_TessLevelOuter[1] = 2.8;
    gl_TessLevelOuter[2] = 2.8;
    gl_TessLevelOuter[3] = 2.8;
}
