#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler0A;
layout(set = 0, binding = 1) uniform highp samplerCubeArray u_combinedTextureSampler0B;
layout(set = 1, binding = 0) uniform highp samplerCubeArray u_combinedTextureSampler1A;
layout(set = 1, binding = 1) uniform highp samplerCubeArray u_combinedTextureSampler1B;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
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
    o_color = result_color;
}
