#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0[2];
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler0[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler0[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-0.953125), float(-0.96875), float(1), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(-0.171875), float(-1), float(0.03125), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler1[0], vec4(float(-1), float(0.28125), float(-0.328125), float(1)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler1[1], vec4(float(1), float(-0.296875), float(0.234375), float(1)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
