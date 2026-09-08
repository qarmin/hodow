#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_OES_texture_cube_map_array : require
layout(triangles) in;
layout(set = 0, binding = 0) uniform highp textureCubeArray u_separateTexture0;
layout(set = 0, binding = 1) uniform highp sampler u_separateSampler0[2];
layout(set = 1, binding = 0) uniform highp textureCubeArray u_separateTexture1;
layout(set = 1, binding = 1) uniform highp sampler u_separateSampler1[2];
layout(location = 1) flat in highp int tes_quadrant_id[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    highp vec4 result_color;
    highp int quadrant_id = tes_quadrant_id[0];
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(samplerCubeArray(u_separateTexture0, u_separateSampler0[0]), vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(samplerCubeArray(u_separateTexture0, u_separateSampler0[1]), vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(samplerCubeArray(u_separateTexture0, u_separateSampler0[0]), vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(samplerCubeArray(u_separateTexture0, u_separateSampler0[1]), vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(samplerCubeArray(u_separateTexture1, u_separateSampler1[0]), vec4(float(-0.976562), float(-0.984375), float(1), float(0)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(samplerCubeArray(u_separateTexture1, u_separateSampler1[1]), vec4(float(-0.585938), float(-1), float(-0.484375), float(0)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(samplerCubeArray(u_separateTexture1, u_separateSampler1[0]), vec4(float(-1), float(-0.359375), float(-0.664062), float(0)), 0.0);
    else
        result_color += textureLod(samplerCubeArray(u_separateTexture1, u_separateSampler1[1]), vec4(float(1), float(-0.648438), float(-0.382812), float(0)), 0.0);
    result_color /= vec4(2.0);

    frag_color = result_color;
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
