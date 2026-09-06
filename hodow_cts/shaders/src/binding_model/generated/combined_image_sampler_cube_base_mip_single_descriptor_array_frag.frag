#version 310 es
layout(set = 0, binding = 0) uniform highp samplerCube u_combinedTextureSampler[2];
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-0.953125), float(-0.96875), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(-0.171875), float(-1), float(0.03125)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(u_combinedTextureSampler[0], vec3(float(-1), float(0.28125), float(-0.328125)), 0.0);
    else
        result_color += textureLod(u_combinedTextureSampler[1], vec3(float(1), float(-0.296875), float(0.234375)), 0.0);
    o_color = result_color;
}
