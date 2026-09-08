#version 310 es
#extension GL_OES_texture_cube_map_array : require
layout(set = 0, binding = 0) uniform highp sampler u_separateSamplerA;
layout(set = 0, binding = 1) uniform highp textureCubeArray u_separateTexture;
layout(set = 0, binding = 2) uniform highp sampler u_separateSamplerB;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
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
}
