#version 310 es
layout(set = 0, binding = 0) uniform highp sampler u_separateSampler0A;
layout(set = 0, binding = 1) uniform highp textureCube u_separateTexture0;
layout(set = 0, binding = 2) uniform highp sampler u_separateSampler0B;
layout(set = 1, binding = 0) uniform highp sampler u_separateSampler1A;
layout(set = 1, binding = 1) uniform highp textureCube u_separateTexture1;
layout(set = 1, binding = 2) uniform highp sampler u_separateSampler1B;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += textureLod(samplerCube(u_separateTexture0, u_separateSampler0A), vec3(float(-0.976562), float(-0.984375), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(samplerCube(u_separateTexture0, u_separateSampler0B), vec3(float(-0.585938), float(-1), float(-0.484375)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(samplerCube(u_separateTexture0, u_separateSampler0A), vec3(float(-1), float(-0.359375), float(-0.664062)), 0.0);
    else
        result_color += textureLod(samplerCube(u_separateTexture0, u_separateSampler0B), vec3(float(1), float(-0.648438), float(-0.382812)), 0.0);
    if (quadrant_id == 0)
        result_color += textureLod(samplerCube(u_separateTexture1, u_separateSampler1A), vec3(float(-0.976562), float(-0.984375), float(1)), 0.0);
    else if (quadrant_id == 1)
        result_color += textureLod(samplerCube(u_separateTexture1, u_separateSampler1B), vec3(float(-0.585938), float(-1), float(-0.484375)), 0.0);
    else if (quadrant_id == 2)
        result_color += textureLod(samplerCube(u_separateTexture1, u_separateSampler1A), vec3(float(-1), float(-0.359375), float(-0.664062)), 0.0);
    else
        result_color += textureLod(samplerCube(u_separateTexture1, u_separateSampler1B), vec3(float(1), float(-0.648438), float(-0.382812)), 0.0);
    result_color /= vec4(2.0);
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
